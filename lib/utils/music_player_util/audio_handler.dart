import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidNotificationChannelId: 'com.mycompany.myapp.audio',
      androidNotificationChannelName: 'LOVE BOOK Notification',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  late final _cacheDir;
  final _player = AudioPlayer();

  // ignore: prefer_typing_uninitialized_variables
  var currentIndex;
  late String? currentSongUrl;
  bool isPlayingUsingLockCachingSource = false;
  bool loopModeEnabled = false;
  var networkErrorPause = false;

  final _playList = ConcatenatingAudioSource(
    children: [],
  );

  Future<void> _createCacheDir() async {
    _cacheDir = (await getTemporaryDirectory()).path;
    if (!Directory("$_cacheDir/cachedSongs/").existsSync()) {
      Directory("$_cacheDir/cachedSongs/").createSync(recursive: true);
    }
  }

  MyAudioHandler() {
    _createCacheDir();
    _addEmptyList();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenToPlaybackForNextSong();
    _listenForSequenceStateChanges();
  }

  void _addEmptyList() {
    try {
      _player.setAudioSource(_playList);
    } catch (r) {
      print(r.toString());
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode]!,
        shuffleMode: (_player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: currentIndex,
      ));

      //print("set ${playbackState.value.queueIndex},${event.currentIndex}");
    }, onError: (Object e, StackTrace st) async {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');

        if (isPlayingUsingLockCachingSource &&
            e.toString().contains("Connection closed while receiving data")) {
          Duration curPos = _player.position;
          await _player.stop();
          await _player.seek(curPos, index: 0);
          await _player.play();
        }

        //Workaround when 403 error encountered
        customAction("playByIndex", {'index': currentIndex, 'newUrl': true})
            .whenComplete(() async {
          await _player.stop();
          if (currentSongUrl == null) {
            networkErrorPause = true;
          } else {
            _player.play();
          }
        });
      }
    });
  }

  void _listenToPlaybackForNextSong() {
    _player.positionStream.listen((value) async {
      if (_player.duration != null &&
          value.inMilliseconds >= _player.duration!.inMilliseconds) {
        await _triggerNext();
      }
    });
  }

  Future<void> _triggerNext() async {
    if (loopModeEnabled) {
      await _player.seek(Duration.zero);
      if (!_player.playing) {
        _player.play();
      }
      return;
    }
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) async {
      var index = currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices![index];
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _listenForSequenceStateChanges() {
    _player.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
    });
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    final newQueue = this.queue.value
      ..replaceRange(0, this.queue.value.length, queue);
    this.queue.add(newQueue);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // notify system
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  AudioSource _createAudioSource(MediaItem? mediaItem, {String? urlMP3}) {
    // final url = mediaItem.extras!['url'] as String;
    //
    // return LockCachingAudioSource(
    //   Uri.parse(url),
    //   cacheFile: File("$_cacheDir/cachedSongs/${mediaItem.id}.mp3"),
    //   tag: mediaItem,
    // );

    String url = urlMP3!;
    return AudioSource.uri(
      Uri.tryParse(url)!,
      tag: mediaItem,
    );
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // notify system
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> removeQueueItem(MediaItem mediaItem_) async {
    final currentQueue = queue.value;
    final currentSong = mediaItem.value;
    final itemIndex = currentQueue.indexOf(mediaItem_);
    if (currentIndex > itemIndex) {
      currentIndex -= 1;
    }
    currentQueue.remove(mediaItem_);
    queue.add(currentQueue);
    mediaItem.add(currentSong);
  }

  @override
  Future<void> play() async {
    if (currentSongUrl == null) {
      await customAction("playByIndex", {'index': currentIndex});
      return;
    }
    // Workaround for network error pause in case of PlayingUsingLockCachingSource
    if (isPlayingUsingLockCachingSource && networkErrorPause) {
      await _player.play();
      Future.delayed(const Duration(seconds: 2)).then((value) {
        if (_player.playing) {
          networkErrorPause = false;
        }
      });
      await _player.play();
      return;
    }
    await _player.play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    await customAction("playByIndex", {'index': index});
  }

  @override
  Future<void> skipToNext() async {
    _player.seek(Duration.zero);
    _player.pause();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    if (repeatMode == AudioServiceRepeatMode.none) {
      loopModeEnabled = false;
    } else {
      loopModeEnabled = true;
    }
  }

  @override
  Future<void> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'dispose') {
      await _player.dispose();
      super.stop();
    } else if (name == 'setSourceNPlay') {
      await _playList.clear();
      currentSongUrl = extras?["mediaItem"]["id"];
      print('Current=== $currentSongUrl');
      await _playList.add(_createAudioSource(null, urlMP3: currentSongUrl));
      await _player.play();
    } else if (name == 'toggleSkipSilence') {
      final enable = (extras!['enable'] as bool);
      await _player.setSkipSilenceEnabled(enable);
    } else if (name == "shuffleQueue") {
      final currentQueue = queue.value;
      final currentItem = currentQueue[currentIndex];
      currentQueue.remove(currentItem);
      currentQueue.shuffle();
      currentQueue.insert(0, currentItem);
      queue.add(currentQueue);
      mediaItem.add(currentItem);
      currentIndex = 0;
      cacheNextSongUrl();
    } else if (name == "reorderQueue") {
      final oldIndex = extras!['oldIndex'];
      int newIndex = extras['newIndex'];

      if (oldIndex < newIndex) {
        newIndex--;
      }

      final currentQueue = queue.value;
      final currentItem = currentQueue[currentIndex];
      final item = currentQueue.removeAt(
        oldIndex,
      );
      currentQueue.insert(newIndex, item);
      currentIndex = currentQueue.indexOf(currentItem);
      queue.add(currentQueue);
      mediaItem.add(currentItem);
    } else if (name == 'addPlayNextItem') {
      final song = extras!['mediaItem'] as MediaItem;
      final currentQueue = queue.value;
      currentQueue.insert(currentIndex + 1, song);
      queue.add(currentQueue);
    } else if (name == 'openEqualizer') {
      // await DeviceEqualizer().open(_player.androidAudioSessionId!);
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  Future<void> cacheNextSongUrl() async {
    if (queue.value.length > currentIndex + 1) {
      print("Next Song Url Cached");
    }
  }
}
