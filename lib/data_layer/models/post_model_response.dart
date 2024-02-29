class PostsModelResponse {
  bool? status;
  Posts? posts;

  PostsModelResponse({this.status, this.posts});

  PostsModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    posts = json['posts'] != null ? new Posts.fromJson(json['posts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.posts != null) {
      data['posts'] = this.posts!.toJson();
    }
    return data;
  }
}

class Posts {
  List<AllPost>? allPost;
  List<AllPost>? myPosts;
  List<Comments>? comments;
  int? totalCount;
  int? index;

  Posts({this.allPost, this.comments, this.totalCount, this.index});

  Posts.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    index = json['index'];
    if (json['all_posts'] != null) {
      allPost = <AllPost>[];
      json['all_posts'].forEach((v) {
        allPost!.add(new AllPost.fromJson(v));
      });
    }
    if (json['my_posts'] != null) {
      myPosts = <AllPost>[];
      json['my_posts'].forEach((v) {
        myPosts!.add(new AllPost.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['total_count'] = this.totalCount;
    if (this.allPost != null) {
      data['all_post'] = this.allPost!.map((v) => v.toJson()).toList();
    }
    if (this.myPosts != null) {
      data['my_posts'] = this.myPosts!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllPost {
  int? id;
  String? userImage;
  String? userName;
  String? createdAt;
  String? media;
  String? mediaTitle;
  String? message;
  int? likes;
  int? comment;
  int? userId;

  AllPost(
      {this.id,
      this.userImage,
      this.userName,
      this.createdAt,
      this.media,
      this.mediaTitle,
      this.message,
      this.likes,
      this.comment,
      this.userId});

  AllPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userImage = json['user_image'];
    userName = json['user_name'];
    createdAt = json['created_at'];
    media = json['media'];
    mediaTitle = json['media_title'];
    message = json['message'];
    likes = json['likes'];
    comment = json['comment'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    data['created_at'] = this.createdAt;
    data['media'] = this.media;
    data['media_title'] = this.mediaTitle;
    data['message'] = this.message;
    data['likes'] = this.likes;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? postId;
  String? userName;
  String? comment;
  String? createdAt;

  Comments(
      {this.id,
      this.userId,
      this.postId,
      this.userName,
      this.comment,
      this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    userName = json['user_name'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['user_name'] = this.userName;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    return data;
  }
}
