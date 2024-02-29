import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../Widget/buttons.dart';
import '../data_layer/controller/community_post_controller.dart';
import '../data_layer/manager/manager.dart';
import '../data_layer/models/user_response.dart';
import '../utils/color.dart';
import '../utils/dialog/snack_bars.dart';
import '../utils/foul_word_checker.dart';
import '../utils/local_storage_data.dart';

class ImageUploadScreen extends ConsumerStatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends ConsumerState<ImageUploadScreen>
    implements OnVideoUpload {
  bool isSuccessful = false;

  File? _pickedImage;
  TextEditingController textEditingController = TextEditingController();

  Future<void> _pickPictureFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _uploadPicture(String? videoPath) async {
    UserData? userData = await LocalDataStorage.getUserData();
    bool isFoul = FoulWordChecker()
        .check(textEditingController.text, (userData?.abusiveWords) ?? []);
    if (isFoul) {
      errorSnack(
        context,
        "Use of profane language is prohibited.",
      );
      return;
    }
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
        // iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        title: Text('Picture Picker'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                await _uploadPicture(_pickedImage?.path);
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
                child: _pickedImage != null
                    ? Image.file(_pickedImage!)
                    : Container()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyButton(
                          btnName: "Pick Image from Gallery",
                          click: _pickPictureFromGallery)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: MyButton(
                          btnName: "Take a picture", click: _takePicture)),
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
    successSnack(context, message);
  }
}
