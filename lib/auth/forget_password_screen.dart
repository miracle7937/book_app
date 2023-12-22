import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../Widget/buttons.dart';
import '../Widget/textFiealds.dart';
import '../data_layer/controller/registraion_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/dialog/snack_bars.dart';
import '../utils/page_state.dart';
import '../utils/scaffold/custom_scaffold.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen>
    implements ForgetPassWordView {
  late RegistrationController controller;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller = ref.watch(registrationController);
    controller.setForgetPasswordView(this);
    return CustomScaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        title: Text(
          'Reset Password',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Forgot Your Password?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFieald(
                controller: textEditingController,
                hintText: "Enter Your Email",
                onChange: (v) {}),
            Spacer(),
            MyButton(
                isLoading: controller.pageState == PageState.loading,
                btnName: "LOGIN",
                click: () {
                  controller.forgetPassword(textEditingController.text);
                })
          ],
        ),
      ),
    );
  }

  @override
  onError(String? message) {
    errorSnack(context, message);
  }

  @override
  onSuccess(String? message) {
    successSnack(context, message);
  }
}
