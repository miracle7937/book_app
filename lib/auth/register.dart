// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constance/constance.dart';
import '../Constance/theme.dart';
import '../Widget/buttons.dart';
import '../Widget/linear_indicator.dart';
import '../Widget/pageview.dart';
import '../Widget/textFiealds.dart';
import '../auth/forget_password_screen.dart';
import '../auth/otp_email_phone_screen.dart';
import '../data_layer/controller/registraion_controller.dart';
import '../data_layer/manager/manager.dart';
import '../utils/biometric_controller.dart';
import '../utils/color.dart';
import '../utils/dialog/snack_bars.dart';
import '../utils/images.dart';
import '../utils/page_state.dart';
import '../utils/themes/theme_manager.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    implements RegView {
  int pageNumber = 0;
  final PageController _pageController = PageController();
  bool isBiometricEnable = false;

  @override
  void initState() {
    super.initState();
    checkBiometric();
  }

  checkBiometric() async {
    isBiometricEnable = await BiometricController.isBiometricEnable();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    RegistrationController controller = ref.watch(registrationController);
    controller.setView(this);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: MediaQuery.of(context).padding.top + 16,
            bottom: MediaQuery.of(context).padding.bottom),
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            children: [
              BookLinearProgressBar(
                isloading: controller.pageState == PageState.loading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    ConstanceData.s2,
                    height: 40,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(0);
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "SIGN IN",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16,
                                  color: pageNumber == 0
                                      ? HexColor("#323232")
                                      : Theme.of(context).disabledColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 3,
                          width: 80,
                          decoration: BoxDecoration(
                            color: pageNumber == 0
                                ? ref.watch(themeController).isLight
                                    ? Colors.black
                                    : Colors.white
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(1);
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16,
                                  color: pageNumber == 1
                                      ? HexColor("#323232")
                                      : Theme.of(context).disabledColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 3,
                          width: 80,
                          decoration: BoxDecoration(
                            color: pageNumber == 1
                                ? ref.watch(themeController).isLight
                                    ? Colors.black
                                    : Colors.white
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      pageNumber = value;
                    });
                  },
                  children: [
                    //****************** *
                    ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        MyTextFieald(
                            inputFormatters: [NonEmptyInputFormatter()],
                            hintText: "Email",
                            onChange: (v) {
                              controller.loginModel.email =
                                  v?.replaceAll(" ", "");
                            }),
                        MyTextFieald(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                ConstanceData.sv2,
                                height: 12,
                              ),
                              onPressed: () {},
                            ),
                            onChange: (v) {
                              controller.loginModel.password = v;
                            }),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ForgetPasswordScreen()));
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        MyButton(
                            isLoading:
                                controller.pageState == PageState.loading,
                            btnName: "LOGIN",
                            click: () {
                              controller.normalLogin();
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        isBiometricEnable
                            ? InkWell(
                                splashColor: AppColor.mainColor,
                                onTap: () async {
                                  controller.biometricLogin();
                                },
                                child: SizedBox(
                                  height: 40,
                                  child: Image.asset(Platform.isAndroid
                                      ? BookImages.fingerPrint
                                      : BookImages.faceID),
                                ))
                            : Container(),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    // *******************
                    ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        MyTextFieald(
                            inputFormatters: [NonEmptyInputFormatter()],
                            hintText: "Email",
                            onChange: (v) {
                              controller.registerModel.email = v;
                            }),
                        MyTextFieald(
                            hintText: "First Name",
                            onChange: (v) {
                              controller.registerModel.firstName = v;
                            }),
                        MyTextFieald(
                            hintText: "Last Name",
                            onChange: (v) {
                              controller.registerModel.lastName = v;
                            }),
                        CustomDropdown(
                          hintText: "Gender",
                          dropdownItems: ["MALE", "FEMALE"],
                          onSelect: (v) {
                            print(v);
                            controller.registerModel.gender = v;
                          },
                        ),
                        MyTextFieald(
                            obscureText: true,
                            hintText: "Password",
                            onChange: (v) {
                              controller.registerModel.password = v;
                            }),
                        SizedBox(
                          height: 60,
                        ),
                        MyButton(
                            isLoading:
                                controller.pageState == PageState.loading,
                            btnName: "REGISTER",
                            click: () {
                              controller.sendOTP();
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String? message) {
    errorSnack(context, message);
  }

  @override
  onVerifyRegistrationData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OTPEmailPhoneScreen(),
      ),
    );
  }

  @override
  onSuccessLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PageScreen()),
      (route) => false, // This clears the stack
    );
  }
}

class NonEmptyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(" ")) {
      return oldValue;
    }
    return newValue;
  }
}
