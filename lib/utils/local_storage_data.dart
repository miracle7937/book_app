import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../data_layer/models/registration_model.dart';
import '../data_layer/models/user_credential_model.dart';
import '../data_layer/models/user_response.dart';
import '../utils/constant_string.dart';

class LocalDataStorage {
  // static const _storage = FlutterSecureStorage();
  static saveUserData(UserData? userData) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(
      ConstantString.userDataKey,
      json.encode(userData!.toJson()),
    );
  }

  static saveLoginData(LoginModel? loginModel) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(
      ConstantString.loginData,
      json.encode(loginModel!.toMap()),
    );
  }

  static savePlans(Plan? plan) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(
      ConstantString.plans,
      json.encode(plan!.toJson()),
    );
  }

  static Future<Plan?> getPlan() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    String? value = _storage.getString(
      ConstantString.plans,
    );
    Map<String, dynamic> map = value != null ? json.decode(value) : {};
    if (map.isNotEmpty) {
      return Plan.fromJson(map);
    }
    return null;
  }

  static Future<String?> getToken() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    String? value = _storage.getString(
      ConstantString.userDataKey,
    );
    Map<String, dynamic> map = value != null ? json.decode(value) : {};
    if (map.isNotEmpty) {
      return UserData.fromJson(map).token;
    }
    return null;
  }

  static Future<UserData?> getUserData() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    String? value = _storage.getString(
      ConstantString.userDataKey,
    );

    Map<String, dynamic> map = value != null ? json.decode(value) : {};
    if (map.isNotEmpty) {
      return UserData.fromJson(map);
    }
    return null;
  }

  static void clearUser() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.remove(
      ConstantString.userDataKey,
    );
  }

  static void saveTheme(bool isLight) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setBool(ConstantString.themeData, isLight);
  }

  static Future<bool> getTheme() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    return _storage.getBool(
          ConstantString.themeData,
        ) ??
        true;
  }

  static saveEnableBiometric(bool hide) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(
      ConstantString.enableBiometric,
      hide.toString(),
    );
  }

  static Future<bool> getBiometricStatus() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    String? value = _storage.getString(ConstantString.enableBiometric);
    bool isEnable = (value == "false" || value == null) ? false : true;
    return isEnable;
  }

  //user creditential
  static saveUserCredential(UserCredentialModel? userCredentialModel) async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    await _storage.setString(
      ConstantString.credential,
      json.encode(userCredentialModel!.toJson()),
    );
  }

  static Future<UserCredentialModel?> getUserCredential() async {
    final SharedPreferences _storage = await SharedPreferences.getInstance();
    String? value = _storage.getString(
      ConstantString.credential,
    );
    Map<String, dynamic> map = value != null ? json.decode(value) : {};
    if (map.isNotEmpty) {
      return UserCredentialModel.fromJson(map);
    }
    return null;
  }
}
