
import 'post_model_response.dart';

class PostCommentModel {
  bool? status;
  CommentData? data;

  PostCommentModel({this.status, this.data});

  PostCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new CommentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommentData {
  List<Comment>? comment;
  List<AllPost>? allPost;

  CommentData({this.comment, this.allPost});

  CommentData.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }

    if (json['post'] != null) {
      allPost = <AllPost>[];
      json['post'].forEach((v) {
        allPost!.add(new AllPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }

    if (this.allPost != null) {
      data['post'] = this.allPost!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  int? userId;
  int? postId;
  String? userImage;
  String? userName;
  String? comment;
  String? createdAt;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.userImage,
      this.userName,
      this.comment,
      this.createdAt});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    userImage = json['user_image'];
    userName = json['user_name'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    return data;
  }
}
