import 'package:flutter/material.dart';

import '../../home_screen/test_audio.dart';
import 'music_player_indicator.dart';

class GlobalMusicIndicator extends StatelessWidget {
  final MusicPlayerIndicatorController indicatorController =
      MusicPlayerIndicatorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyAppTetMusic()),
        );
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: indicatorController.isPlaying,
        builder: (context, isPlaying, _) {
          return Container(
            // Your indicator UI goes here
            padding: EdgeInsets.all(8.0),
            color: Colors.blue, // Customize the color or use an icon
            child: Text(isPlaying ? 'Music is playing' : 'Music stopped'),
          );
        },
      ),
    );
  }
}
