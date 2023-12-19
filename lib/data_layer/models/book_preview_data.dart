class BookPreviewData {
  bool? status;
  PreviewData? data;

  BookPreviewData({this.status, this.data});

  BookPreviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new PreviewData.fromJson(json['data']) : null;
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

class PreviewData {
  List<PreviewBook>? book;
  List<Review>? review;
  List<SimilarByAuthor>? similarByAuthor;

  PreviewData({this.book, this.review, this.similarByAuthor});

  PreviewData.fromJson(Map<String, dynamic> json) {
    if (json['book'] != null) {
      book = <PreviewBook>[];
      json['book'].forEach((v) {
        book!.add(new PreviewBook.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
    if (json['similar_by_author'] != null) {
      similarByAuthor = <SimilarByAuthor>[];
      json['similar_by_author'].forEach((v) {
        similarByAuthor!.add(new SimilarByAuthor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.map((v) => v.toJson()).toList();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    if (this.similarByAuthor != null) {
      data['similar_by_author'] =
          this.similarByAuthor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreviewBook {
  int? id;
  String? pdf;
  String? image;
  String? title;
  String? author;
  String? description;
  String? audio;
  int? reads;
  int? rating;

  PreviewBook(
      {this.title,
      this.author,
      this.description,
      this.audio,
      this.reads,
      this.rating});

  PreviewBook.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    description = json['description'];
    audio = json['audio'];
    reads = json['reads'];
    id = json['id'];
    pdf = json['pdf'];
    image = json['images'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['audio'] = this.audio;
    data['reads'] = this.reads;
    data['id'] = this.id;
    data['pdf'] = this.pdf;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}

class Review {
  String? userProfilePics;
  int? rating;
  String? userName;
  String? createdAt;
  String? comment;

  Review({this.userProfilePics, this.rating, this.userName, this.createdAt});

  Review.fromJson(Map<String, dynamic> json) {
    userProfilePics = json['user_profile_pics'];
    rating = json['rating'];
    userName = json['user_name'];
    createdAt = json['created_at'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_profile_pics'] = this.userProfilePics;
    data['rating'] = this.rating;
    data['user_name'] = this.userName;
    data['created_at'] = this.createdAt;
    data['comment'] = this.comment;
    return data;
  }
}

class SimilarByAuthor {
  String? title;
  String? images;
  int? id;

  SimilarByAuthor({this.title, this.images, this.id});

  SimilarByAuthor.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    images = json['images'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['images'] = this.images;
    data['id'] = this.id;
    return data;
  }
}
