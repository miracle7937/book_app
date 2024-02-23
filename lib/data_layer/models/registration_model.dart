import '../../utils/constant_string.dart';

class RegisterModel {
  String? email;
  String? deviceId;
  String? firstName;
  String? lastName;
  String? gender;
  String? password;

  RegisterModel({
    this.email,
    this.deviceId,
    this.firstName,
    this.lastName,
    this.gender,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'device_id': deviceId,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'password': password,
    };
  }

  String? validateRegistration() {
    if (email == null || !ConstantString.isValidEmail(email!)) {
      return 'Invalid email';
    }

    if (firstName == null || firstName!.isEmpty) {
      return 'First name is required';
    }

    if (lastName == null || lastName!.isEmpty) {
      return 'Last name is required';
    }

    if (password == null || password!.length < 4) {
      return 'Password must be at least 4 characters';
    }

    // If all validations pass, return null
    return null;
  }
}

class LoginModel {
  String? email;
  String? password;

  LoginModel({
    this.email,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String? validateLogin() {
    if (email == null || !ConstantString.isValidEmail(email!)) {
      return 'Invalid email';
    }

    if (password == null || password!.length < 4) {
      return 'Password must be at least 4 characters';
    }

    // If all validations pass, return null
    return null;
  }
}
