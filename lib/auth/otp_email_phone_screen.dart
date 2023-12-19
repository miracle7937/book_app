import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovebook/Widget/buttons.dart';
import 'package:lovebook/utils/dialog/snack_bars.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Widget/linear_indicator.dart';
import '../Widget/status_screen.dart';
import '../data_layer/controller/registraion_controller.dart';
import '../data_layer/manager/manager.dart';
import '../main.dart';
import '../utils/count_down_util.dart';
import '../utils/navigation_service.dart';
import '../utils/page_state.dart';

class OTPEmailPhoneScreen extends ConsumerStatefulWidget {
  const OTPEmailPhoneScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OTPEmailPhoneScreen> createState() =>
      _OTPEmailPhoneScreenState();
}

class _OTPEmailPhoneScreenState extends ConsumerState<OTPEmailPhoneScreen>
    implements OTPAuthUserView {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool sendToken = false;
  late CountdownOTP _countdownOTP;
  @override
  void initState() {
    textEditingController = TextEditingController();
    _countdownOTP = CountdownOTP(countSec: 60);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _countdownOTP.dispose();
    super.dispose();
  }

  RegistrationController? controller;
  @override
  Widget build(BuildContext context) {
    controller =
        controller = ref.watch(registrationController)?..otpView = this;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Verification'),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              BookLinearProgressBar(
                isloading: controller?.pageState == PageState.loading,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Email Verification',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: RichText(
                        text: TextSpan(
                          text: "Enter the code sent to  ",
                          children: [
                            TextSpan(
                              text: "${controller?.registerModel.email}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            appContext: context,

                            pastedTextStyle: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold),

                            length: 4,
                            obscureText: true,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,

                            validator: (v) {
                              if (v!.length < 3) {
                                return null;
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              errorBorderColor: Colors.white,
                              selectedColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              disabledColor: Colors.white,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              controller?.setOTp(v);
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                          // style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        StreamBuilder<String?>(
                            stream: _countdownOTP.timerStream,
                            builder: (_, snap) => TextButton(
                                onPressed: () {
                                  snap.hasData ? null : controller?.reSendOTP();
                                },
                                child: Text(
                                  snap.hasData
                                      ? (snap.data.toString())
                                      : "SEND CODE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    MyButton(
                      isLoading: controller?.pageState == PageState.loading
                          ? true
                          : false,
                      btnName: "VERIFY".toUpperCase(),
                      click: () {
                        formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.length < 4) {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          controller?.otpVerification();
                          setState(
                            () {
                              hasError = false;
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(String message) {
    errorController!.add(ErrorAnimationType.shake);
    errorSnack(
      context,
      message,
    );
  }

  @override
  void onSuccess(String message) {
    _countdownOTP.count();
    successSnack(context, "OTP resend!!");
  }

  @override
  void onVerify(String message) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => StatusScreen(
                  title: message,
                  onTap: () {
                    Navigator.of(NavigationService.navigatorKey.currentContext!)
                        .pushNamedAndRemoveUntil(
                      Routes.signInScreen,
                      (route) => false,
                    );
                  },
                )));
  }

  @override
  void onRegister() {}

  @override
  void onRegistrationSuccess(String message) {}
}
