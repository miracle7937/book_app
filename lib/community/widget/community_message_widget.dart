import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidecampus/utils/local_storage_data.dart';

import '../../data_layer/manager/manager.dart';
import '../../utils/color.dart';
import '../../utils/dialog/snack_bars.dart';
import '../../utils/foul_word_checker.dart';
import '../../utils/images.dart';
import '../../utils/string_helper.dart';
import '../../utils/themes/theme_manager.dart';
import '../image_upload_screen.dart';
import '../video_upload_screen.dart';

class CommunityMessageWidget extends StatelessWidget {
  CommunityMessageWidget({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ref.watch(themeController).isLight
                ? Colors.white
                : Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color with alpha
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
                    InkWell(
                        onTap: () async {
                          var isSuccessful = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ImageUploadScreen()));

                          if (isSuccessful == true) {
                            ref.watch(communityManager).refresh();
                          }
                        },
                        child: Image.asset(BookImages.imagePicker)),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          var isSuccessful = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoPickerScreen()));

                          if (isSuccessful == true) {
                            ref.watch(communityManager).refresh();
                          }
                        },
                        child: Image.asset(BookImages.videoPicker)),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (isNotEmpty(textEditingController.text)) {
                          LocalDataStorage.getUserData().then((value) {
                            bool isFoul = FoulWordChecker().check(
                                textEditingController.text,
                                (value?.abusiveWords) ?? []);
                            if (isFoul) {
                              errorSnack(
                                context,
                                "Use of profane language is prohibited.",
                              );
                            } else {
                              ref
                                  .watch(communityManager)
                                  .postWithNoMedia(textEditingController.text);
                            }
                          });
                        }
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Post",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
