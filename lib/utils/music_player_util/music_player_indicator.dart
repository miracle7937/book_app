import 'package:flutter/cupertino.dart';

class MusicPlayerIndicatorController {
  static final MusicPlayerIndicatorController _instance =
      MusicPlayerIndicatorController._internal();

  factory MusicPlayerIndicatorController() {
    return _instance;
  }

  MusicPlayerIndicatorController._internal();

  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
}
