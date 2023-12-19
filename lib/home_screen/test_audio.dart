import 'dart:developer';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/color.dart';
import '../utils/music_player_util/music_player_indicator.dart';

class MyAppTetMusic extends StatelessWidget {
  AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Music',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Background Music'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                child: Text('Play Music'),
                onPressed: () {
                  playBackgroundMusic();
                },
              ),
              SizedBox(height: 20),
              PlaybackSlider(
                audioPlayer: player,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void playBackgroundMusic() async {
    await player.setUrl(
        'https://sidecampus.bplux.store/public/assets/AShamaluevMusic.mp3');

    if (Platform.isAndroid) {
      AudioService.start(
        backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
        androidNotificationChannelName: 'Background Music',
        androidNotificationColor: 0xFF2196f3,
        androidNotificationIcon: 'mipmap/ic_launcher',
      );

      AudioServiceBackground.setState(
        playing: true,
        processingState: AudioProcessingState.ready,
        position: Duration.zero,
      );
    }

    await player.play();
  }
}

void audioPlayerTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  AudioPlayer player = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(
      playing: true,
      processingState: AudioProcessingState.ready,
      position: player.position,
    );
    player.play();
  }

  @override
  Future<void> onStop() async {
    player.stop();
    await player.dispose();
    await super.onStop();
  }
}

class PlaybackSlider extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const PlaybackSlider({super.key, required this.audioPlayer});
  @override
  _PlaybackSliderState createState() => _PlaybackSliderState();
}

class _PlaybackSliderState extends State<PlaybackSlider> {
  late AudioPlayer player;
  bool isPlaying = false;
  final MusicPlayerIndicatorController indicatorController =
      MusicPlayerIndicatorController();

  double _sliderValue = 0.0;
  double _maxDuration = 1.0;
  @override
  void initState() {
    super.initState();
    player = widget.audioPlayer;
    player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _sliderValue = position.inSeconds.toDouble();
          print(position.inSeconds.toString());
        });
      }
    });
    player.playerStateStream.listen((event) {
      isPlaying = event.playing;
      log("IS it playing ==================> $isPlaying");
      indicatorController.isPlaying.value = event.playing;
    });

    player.durationStream.listen((duration) {
      print('MIMI $duration');
      if (mounted) {
        setState(() {
          _maxDuration = duration!.inSeconds.toDouble();
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration(minutes: 1);

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: FlutterSlider(
            jump: true,
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
                border: Border.all(width: 3, color: Colors.white),
              ),
              activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.mainColor),
            ),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
            handlerAnimation: FlutterSliderHandlerAnimation(
                curve: Curves.elasticOut,
                reverseCurve: Curves.bounceIn,
                duration: Duration(milliseconds: 500),
                scale: 1.5),
            values: [_sliderValue],
            min: 0,
            max: duration.inSeconds.toDouble(),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              print(upperValue.toString());
              player.seek(Duration(seconds: lowerValue.round()));
            },
          ),
        );
      },
    );
  }
}
