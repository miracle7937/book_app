import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovebook/Widget/buttons.dart';
import 'package:lovebook/profile/widget/select_image_view.dart';

import '../Widget/textFiealds2.dart';
import '../data_layer/controller/profile_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/dialog/snack_bars.dart';

class UserUpdateScreen extends ConsumerStatefulWidget {
  const UserUpdateScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends ConsumerState<UserUpdateScreen>
    implements UserUpdateView {
  late ProfileController profileController;
  @override
  Widget build(BuildContext context) {
    profileController = ref.watch(profileBookManager)..setView(this);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        title: Text(
          'Update User',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SelectImageView(
                file: profileController.fileImage,
                onTap: () {
                  profileController.selectImage();
                },
                title: "Take A Picture",
              ),
              MyTextFieald2(
                onChange: (v) {
                  profileController.firstName = v;
                },
                hintText: 'First Name',
              ),
              SizedBox(
                height: 20,
              ),
              MyTextFieald2(
                onChange: (v) {
                  profileController.lastName = v;
                },
                hintText: 'Last Name',
              ),
              Spacer(),
              MyButton(
                btnName: "Submit",
                click: () {
                  profileController.updateUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String error) {
    errorSnack(context, error);
  }

  @override
  onSuccess(String message) {
    successSnack(context, message);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }
}
