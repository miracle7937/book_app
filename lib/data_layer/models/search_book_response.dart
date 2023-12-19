class SearchBookResponse {
  bool? status;
  List<FullBookData>? data;

  SearchBookResponse({this.status, this.data});

  SearchBookResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <FullBookData>[];
      json['data'].forEach((v) {
        data!.add(new FullBookData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FullBookData {
  int? id;
  String? title;
  String? description;
  String? year;
  String? author;
  String? pdf;
  String? audio;
  int? pages;
  String? createdAt;
  String? updatedAt;
  String? category;
  String? images;
  int? plays;
  int? views;
  int? reads;
  int? rating;

  FullBookData(
      {this.id,
      this.title,
      this.description,
      this.year,
      this.author,
      this.pdf,
      this.audio,
      this.pages,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.images,
      this.plays,
      this.views,
      this.reads,
      this.rating});

  FullBookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    year = json['year'];
    author = json['author'];
    pdf = json['pdf'];
    audio = json['audio'];
    pages = json['pages'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
    images = json['images'];
    plays = json['plays'];
    views = json['views'];
    reads = json['reads'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['year'] = this.year;
    data['author'] = this.author;
    data['pdf'] = this.pdf;
    data['audio'] = this.audio;
    data['pages'] = this.pages;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    data['images'] = this.images;
    data['plays'] = this.plays;
    data['views'] = this.views;
    data['reads'] = this.reads;
    data['rating'] = this.rating;
    return data;
  }
}
