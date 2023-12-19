import 'package:lovebook/data_layer/models/generic_reponse.dart';
import 'package:lovebook/data_layer/models/registration_model.dart';

import '../api_route/api_route.dart';
import '../models/user_response.dart';
import '../request.dart';

class RegistrationRepository {
  final ServerRequest read;

  RegistrationRepository(this.read);

  static Future<GenericResponse> register(RegisterModel model) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.registration, body: model.toMap());
    return GenericResponse.fromJson(service.data);
  }

  static Future<UserResponse> login(LoginModel model) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.login, body: model.toMap());
    return UserResponse.fromJson(service.data);
  }

  static Future<GenericResponse> sendOTPAuthenticatedUser(Map data) async {
    final service =
        await ServerRequest().postData(path: ApiRoute.sendOTP, body: data);
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> forgetPassword(Map data) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.forgetPassword, body: data);
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> resendOTP(Map data) async {
    final service =
        await ServerRequest().postData(path: ApiRoute.resendOTP, body: data);
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> verifyOTP(Map data) async {
    final service =
        await ServerRequest().postData(path: ApiRoute.verifyOTP, body: data);
    return GenericResponse.fromJson(service.data);
  }
}
