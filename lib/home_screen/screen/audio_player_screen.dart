import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:lovebook/data_layer/models/book_preview_data.dart';
import 'package:lovebook/utils/color.dart';

class AudioPlayerScreen extends StatefulWidget {
  final PreviewBook? book;
  const AudioPlayerScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  late String audioUrl;

  double _sliderValue = 0.0;
  double _maxDuration = 1.0;
  bool isPlaying = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    audioUrl = widget.book?.audio ?? "";
    log(audioUrl);
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _maxDuration = duration.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _sliderValue = duration.inSeconds.toDouble();
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });
    //play on load
    _audioPlayer.play(UrlSource(audioUrl));
  }

  String _formatDuration(double seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = (seconds % 60).round();
    return '$minutes:${remainingSeconds < 10 ? '0' : ''}$remainingSeconds';
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      _audioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.4,
              imageUrl: widget.book?.image ?? "",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.book?.title ?? "",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_formatDuration(_sliderValue)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '${_formatDuration(_maxDuration)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            FlutterSlider(
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
              max: _maxDuration,
              min: 0,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _audioPlayer.seek(Duration(seconds: lowerValue.toInt()));
              },
              tooltip: FlutterSliderTooltip(disabled: true),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.fast_rewind,
                    size: 30,
                  ),
                  onPressed: () {
                    _audioPlayer.getDuration().then((value) {
                      _audioPlayer.seek(Duration(
                        seconds: ((value?.inSeconds ?? 0) * 0.9).toInt(),
                      ));
                    });
                  },
                ),
                PlayPauseButton(
                  isPlaying: isPlaying,
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play(UrlSource(audioUrl));
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_forward, size: 30),
                  onPressed: () {
                    _audioPlayer.getDuration().then((value) {
                      _audioPlayer.seek(Duration(
                        seconds: ((value?.inSeconds ?? 0) * 1.1).toInt(),
                      ));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final Function onPressed;

  PlayPauseButton({required this.isPlaying, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration:
            BoxDecoration(color: AppColor.mainColor, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 48.0,
            color: Colors.white,
          ),
        ),
      ),
      onTap: onPressed as void Function()?,
    );
  }
}
