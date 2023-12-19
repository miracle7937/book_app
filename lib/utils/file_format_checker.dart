import 'package:path/path.dart';

class FileFormatChecker {
  static FileFormat checkFileType(String? urlOrPath) {
    if (urlOrPath == null) {
      print("$urlOrPath this file path is null");
      return FileFormat.none;
    }
    print(urlOrPath);

    String fileExtension = extension(urlOrPath.toLowerCase());

    if (imageExtensions.contains(fileExtension)) {
      return FileFormat.image;
    } else if (videoExtensions.contains(fileExtension)) {
      return FileFormat.video;
    } else if (audioExtensions.contains(fileExtension)) {
      return FileFormat.audio;
    }
    return FileFormat.none;
  }

  static const List<String> imageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
  ];

  static const List<String> videoExtensions = [
    '.mp4',
    '.avi',
    '.mov',
    '.mkv',
  ];

  static const List<String> audioExtensions = [
    '.mp3',
    '.wav',
    '.ogg',
  ];
}

enum FileFormat { video, image, audio, none }
