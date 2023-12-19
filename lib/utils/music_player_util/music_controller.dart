import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../data_layer/models/audio_player_model.dart';
import '../../main.dart';
import '../slide_up_panel.dart';
import 'duration_state.dart';

class MusicController extends ChangeNotifier {
  PanelController playerPanelController = PanelController();
  late StreamSubscription<bool> keyboardSubscription;
  var playerPanelMinHeight = 0.0;
  bool _initFlagForPlayer = true;
  var playerPaneOpacity = (1.0);
  var isPlayerpanelTopVisible = true;
  var isPlayerPaneDraggable = true;
  var _audioHandler = audioHandler;
  final currentQueue = <MediaItem>[];
  var buttonState = PlayButtonState.paused;
  final progressBarStatus = ProgressBarState(
      buffered: Duration.zero, current: Duration.zero, total: Duration.zero);
  final GlobalKey<ScaffoldState> homeScaffoldkey = GlobalKey<ScaffoldState>();
  String? imageOFAudio;

  MusicController() {
    _init();
  }

  setHidValue() {
    playerPanelMinHeight = 70.0;
    notifyListeners();
  }

  _init() {
    _listenForKeyboardActivity();
    _listenForChangesInPlayerState();
    _listenForChangesInPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInDuration();
  }

  openPlayerModal(AudioData? audioData) async {
    playerPanelMinHeight = 70;
    playerPanelController.show();
    String url = audioData!.audio!;
    imageOFAudio = audioData.images!;
    //play sound
    await _audioHandler.customAction(
      "setSourceNPlay",
      {
        'mediaItem': {"id": url}
      },
    );
  }

  closePlayerModal() async {
    playerPanelMinHeight = 0.0;
    playerPanelController.hide();
    _audioHandler.stop();
    notifyListeners();
  }

  void panellistener(double x) {
    if (x >= 0 && x <= 0.2) {
      playerPaneOpacity = 1 - (x * 6);
      isPlayerpanelTopVisible = true;
    }
    if (x > 0.2) {
      isPlayerpanelTopVisible = false;
    }
    if (x > 0) {
      isPlayerPaneDraggable = false;
    } else {
      isPlayerPaneDraggable = true;
    }
    notifyListeners();
  }

  void _listenForKeyboardActivity() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      visible ? playerPanelController.hide() : playerPanelController.show();
    });
  }

  void _listenForChangesInPlayerState() {
    _audioHandler.playbackState.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        buttonState = PlayButtonState.loading;
      } else if (!isPlaying) {
        buttonState = PlayButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        buttonState = PlayButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
      notifyListeners();
    });
  }

  void _listenForChangesInPosition() {
    AudioService.position.listen((position) {
      print("FUCK MIRCLE Position $position");
      final oldState = progressBarStatus;
      progressBarStatus.current = position;
      progressBarStatus.buffered = oldState.buffered;
      progressBarStatus.total = oldState.total;
      notifyListeners();
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      print("FUCK MIRCLE $playbackState");
      final oldState = progressBarStatus;
      progressBarStatus.buffered = playbackState.bufferedPosition;
      progressBarStatus.current = oldState.current;
      progressBarStatus.total = oldState.total;
      notifyListeners();
    });
  }

  void _listenForChangesInDuration() {
    _audioHandler.mediaItem.listen((mediaItem) async {
      print("FUCK MIRCLE Duration $mediaItem");
      final oldState = progressBarStatus;

      progressBarStatus.total = mediaItem?.duration ?? Duration.zero;
      progressBarStatus.current = oldState.current;
      progressBarStatus.buffered = oldState.buffered;
      notifyListeners();
    });
  }

  playSONG() async {
    await _audioHandler.customAction("setSourceNPlay", {'mediaItem': null});
  }

  Future<void> pushSongToQueue(MediaItem? mediaItem,
      {String? playlistid, bool radio = false}) async {
    Future.delayed(
      Duration.zero,
      () async {
        // radioContinuationParam = content['additionalParamsForNext'];
        // await _audioHandler
        //     .updateQueue(List<MediaItem>.from(content['tracks']));
      },
    ).then((value) async {
      if (playlistid != null) {
        _playerPanelCheck();
        await _audioHandler.customAction("playByIndex", {"index": 0});
      }
    });

    if (playlistid != null) {
      return;
    }

    // currentSong.value = mediaItem;
    _playerPanelCheck();
    await _audioHandler
        .customAction("setSourceNPlay", {'mediaItem': mediaItem});
  }

  void _playerPanelCheck() {
    if (playerPanelController.isAttached) {
      playerPanelController.open();
    }

    if (_initFlagForPlayer) {
      // playerPanelMinHeight = 75.0 + Get.mediaQuery.viewPadding.bottom;
      _initFlagForPlayer = false;
    }
  }

  void fastForward() {
    Duration forwardSecond = progressBarStatus.current + Duration(seconds: 10);
    _audioHandler.seek(forwardSecond);
  }

  void backward() {
    Duration forwardSecond = progressBarStatus.current - Duration(seconds: 10);
    _audioHandler.seek(forwardSecond);
  }

  void seek(Duration position) {
    _audioHandler.seek(position);
  }

  void play() {
    _audioHandler.play();
  }

  void pause() {
    _audioHandler.pause();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
}

enum PlayButtonState { paused, playing, loading }
