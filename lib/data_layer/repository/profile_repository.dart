import 'package:lovebook/data_layer/models/generic_reponse.dart';
import 'package:lovebook/data_layer/models/user_response.dart';

import '../api_route/api_route.dart';
import '../models/contact_us_model.dart';
import '../models/legal_terms_model.dart';
import '../request.dart';

class RepoRepository {
  static Future<GenericResponse> uploadUser(
      Map? body, List<FileKeyValue>? fileKeyValue) async {
    final service = await ServerRequest().uploadFile(
        path: ApiRoute.updateUser, body: body, fileKeyValue: fileKeyValue);
    return GenericResponse.fromJson(service.data);
  }

  static Future<ContactUsModel> getContactUs() async {
    final service = await ServerRequest().getData(path: ApiRoute.contactUs);
    return ContactUsModel.fromJson(service.data);
  }

  static Future<LegalTermsModel> getLegalTerms() async {
    final service = await ServerRequest().getData(path: ApiRoute.legal);
    return LegalTermsModel.fromJson(service.data);
  }

  static Future<GenericResponse> deleteCard(String cardID) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.deleteCard, body: {"card_id": cardID});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> deleteAccount() async {
    final service = await ServerRequest().getData(path: ApiRoute.deleteAccount);
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> logOut() async {
    final service = await ServerRequest().postData(path: ApiRoute.logOut);
    return GenericResponse.fromJson(service.data);
  }

  static Future<UserResponse> getUser() async {
    final service = await ServerRequest().getData(path: ApiRoute.getUser);
    return UserResponse.fromJson(service.data);
  }
}
