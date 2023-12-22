import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/color.dart';
import 'package:video_player/video_player.dart';

import '../Widget/buttons.dart';
import '../data_layer/controller/community_post_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/dialog/snack_bars.dart';

class VideoPickerScreen extends ConsumerStatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends ConsumerState<VideoPickerScreen>
    implements OnVideoUpload {
  bool isSuccessful = false;
  File? _pickedVideo;
  VideoPlayerController? _videoController;
  TextEditingController textEditingController = TextEditingController();

  Future<void> _pickVideoFromGallery() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedVideo = File(pickedFile.path);
      _initializeVideoController(pickedFile.path);
    }
  }

  Future<void> _recordVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      _pickedVideo = File(pickedFile.path);
      _initializeVideoController(pickedFile.path);
    }
  }

  void _initializeVideoController(String videoPath) {
    _videoController = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play();
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _toggleVideoPlayback() {
    if (_videoController != null) {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    }
  }

  Future<void> _uploadVideo(String? videoPath) async {
    ref
        .watch(videoUploadProvider)
        .uploadVideo(videoPath, textEditingController.text)
        .then((v) => Navigator.of(context).pop(isSuccessful));
    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                        '${(ref.watch(videoUploadProvider).state * 100).toStringAsFixed(2)}% uploaded'),
                  ],
                ),
              );
            },
          );
        },
      );
    } finally {
      Navigator.of(context).pop(isSuccessful); // Close the progress dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(videoUploadProvider).setVideoView(this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Video Picker'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                await _uploadVideo(_pickedVideo?.path);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Upload")),
                ),
                decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), // Shadow color with alpha
                    spreadRadius: 0,
                    blurRadius: 8, // Blur radius
                    offset: Offset(0, 4), // Vertical offset for bottom shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Hero(
                      tag: "Image_Picker_screen",
                      child: Material(
                        child: TextFormField(
                          controller: textEditingController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Whats on your mind.....",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Spacer()
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: _videoController != null
                    ? GestureDetector(
                        onTap: _toggleVideoPlayback,
                        child: AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        ),
                      )
                    : Container()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyButton(
                          btnName: "Pick Video from Gallery",
                          click: _pickVideoFromGallery)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: MyButton(
                          btnName: "Record Video", click: _recordVideo)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) {
    errorSnack(context, message);
  }

  @override
  onSuccessful(String message) {
    isSuccessful = true;
    successSnack(context, message);
  }
}
