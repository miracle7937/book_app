import 'dart:developer';

import 'package:flutter/cupertino.dart';


import '../../utils/biometric_controller.dart';
import '../../utils/local_storage_data.dart';
import '../../utils/page_state.dart';
import '../models/registration_model.dart';
import '../models/user_credential_model.dart';
import '../repository/registration_repo.dart';
import '../request.dart';

class RegistrationController extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel();
  LoginModel loginModel = LoginModel();
  PageState pageState = PageState.loaded;
  RegView? _view;
  OTPAuthUserView? _otpAuthUserView;
  ForgetPassWordView? forgetPassWordView;

  String? otp;

  setForgetPasswordView(v) {
    forgetPassWordView = v;
  }

  setView(v) {
    _view = v;
  }

  set otpView(v) {
    _otpAuthUserView = v;
  }

  setOTp(String v) {
    this.otp = v;
  }

  Future<void> register() async {
    try {
      if (registerModel.validateRegistration() != null) {
        _otpAuthUserView?.onError(registerModel.validateRegistration() ?? "");
      } else {
        pageState = PageState.loading;
        notifyListeners();
        final data = await RegistrationRepository.register(registerModel);
        if (data.status == true) {
          _otpAuthUserView?.onVerify(data.message ?? "");
        } else {
          _otpAuthUserView?.onError(data.message ?? "");
        }
        pageState = PageState.loaded;
        notifyListeners();
      }
    } catch (error, v) {
      _otpAuthUserView?.onError(error.toString());
      pageState = PageState.loaded;
      notifyListeners();
    }
  }

  void biometricLogin() async {
    UserCredentialModel? _credentialModel =
        await LocalDataStorage.getUserCredential();
    loginModel.email = _credentialModel?.email;
    loginModel.password = _credentialModel?.password;

    print(loginModel.toMap());
    BiometricController.authenticate().then((value) {
      if (value == true) {
        login(loginModel);
      }
    });
  }

  normalLogin() {
    UserCredentialModel? userCredentialModel = UserCredentialModel();
    userCredentialModel.password = loginModel.password;
    userCredentialModel.email = loginModel.email;
    LocalDataStorage.saveUserCredential(userCredentialModel);
    login(loginModel);
  }

  Future<void> login(LoginModel loginModel) async {
    try {
      if (loginModel.validateLogin() != null) {
        _view?.onError(loginModel.validateLogin());
      } else {
        pageState = PageState.loading;
        notifyListeners();

        final data = await RegistrationRepository.login(loginModel);
        if (data.status == true) {
          LocalDataStorage.saveUserData(data.data);
          LocalDataStorage.saveLoginData(loginModel);
          _view?.onSuccessLogin();
        } else {
          _view?.onError(data.message);
        }
        pageState = PageState.loaded;
        notifyListeners();
      }
    } catch (error, v) {
      log(v.toString());
      _view?.onError(error.toString());
      pageState = PageState.loaded;
      notifyListeners();
    }
  }

  reSendOTP() {
    Map data = {"email": registerModel.email};

    pageState = PageState.loading;
    notifyListeners();
    RegistrationRepository.resendOTP(data).then((value) {
      if (value.status == true) {
        _otpAuthUserView?.onSuccess(value.message.toString());
      } else {
        _otpAuthUserView?.onError(value.message.toString());
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).onError((error, i) {
      print(i);
      _otpAuthUserView?.onError(error.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  sendOTP() {
    if (registerModel.validateRegistration() != null) {
      _view?.onError(registerModel.validateRegistration());
    } else {
      Map data = {"email": registerModel.email};

      pageState = PageState.loading;
      notifyListeners();
      RegistrationRepository.sendOTPAuthenticatedUser(data).then((value) {
        if (value.status == true) {
          _view?.onVerifyRegistrationData();
        } else {
          _view?.onError(value.message.toString());
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).onError((error, i) {
        print(i);
        _view?.onError(error.toString());
        pageState = PageState.loaded;
        notifyListeners();
      });
    }
  }

  forgetPassword(String email) {
    Map data = {"email": registerModel.email};
    pageState = PageState.loading;
    notifyListeners();
    RegistrationRepository.forgetPassword(data).then((value) {
      if (value.status == true) {
        forgetPassWordView?.onSuccess(value.message);
      } else {
        forgetPassWordView?.onError(value.message.toString());
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).onError((error, i) {
      print(i);
      forgetPassWordView?.onError(error.toString());
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  otpVerification() async {
    Map data = {"email": registerModel.email, "code": otp};
    try {
      pageState = PageState.loading;
      notifyListeners();
      var result = await RegistrationRepository.verifyOTP(
        data,
      );

      if (result.status == true) {
        // if true register
        await register();
      } else {
        _otpAuthUserView?.onError(result.message!);
      }
      pageState = PageState.loaded;
      notifyListeners();
    } catch (e) {
      pageState = PageState.loaded;
      notifyListeners();
      if (e is HttpException) {
        _otpAuthUserView?.onError((e).getMessage);
        return;
      }
      _otpAuthUserView?.onError((e).toString());
    }
  }
}

abstract class RegView {
  onVerifyRegistrationData();
  onSuccessLogin();
  onError(String? message);
}

abstract class ForgetPassWordView {
  onError(String? message);
  onSuccess(String? message);
}

abstract class OTPAuthUserView {
  void onSuccess(String message);
  void onError(String message);
  void onVerify(String message);
  void onRegister();
  void onRegistrationSuccess(String message);
}
