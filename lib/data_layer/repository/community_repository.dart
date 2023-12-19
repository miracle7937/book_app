import '../api_route/api_route.dart';
import '../models/generic_reponse.dart';
import '../models/post_comment_model.dart';
import '../models/post_model_response.dart';
import '../request.dart';

class CommunityRepository {
  static Future<PostsModelResponse> getALLPost(int index) async {
    final service = await ServerRequest().getData(
      path: ApiRoute.allPost(index),
    );
    return PostsModelResponse.fromJson(service.data);
  }

  static Future<PostsModelResponse> getMyPost(int index) async {
    final service = await ServerRequest().getData(
      path: ApiRoute.getMyPost(index),
    );
    return PostsModelResponse.fromJson(service.data);
  }

  static Future<GenericResponse> uploadUser(
      Map? body, List<FileKeyValue>? fileKeyValue) async {
    final service = await ServerRequest().uploadFile(
        path: ApiRoute.post, body: body, fileKeyValue: fileKeyValue);
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> likePost(String id) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.likePost, body: {"post_id": id});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> unLikePost(String id) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.unlikePost, body: {"post_id": id});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> deleteComment(String id) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.deleteComment, body: {"post_id": id});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> deletePost(String id) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.deletePost, body: {"post_id": id});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> postComment(String id, message) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.comment, body: {"post_id": id, "comment": message});
    return GenericResponse.fromJson(service.data);
  }

  static Future<PostCommentModel> openPost(String? id) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.open_post, body: {"post_id": id});
    return PostCommentModel.fromJson(service.data);
  }

  static Future<GenericResponse> postWithNoMedia(String message) async {
    final service = await ServerRequest()
        .postData(path: ApiRoute.post, body: {"message": message});
    return GenericResponse.fromJson(service.data);
  }

  static Future<GenericResponse> postEdit(String id, message) async {
    final service = await ServerRequest().postData(
        path: ApiRoute.comment, body: {"post_id": id, "message": message});
    return GenericResponse.fromJson(service.data);
  }
}
