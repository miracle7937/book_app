class ReadBookModel {
  bool? status;
  ReadBookData? data;

  ReadBookModel({this.status, this.data});

  ReadBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? new ReadBookData.fromJson(json['data']) : null;
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

class ReadBookData {
  List<Book>? book;

  ReadBookData({this.book});

  ReadBookData.fromJson(Map<String, dynamic> json) {
    if (json['book'] != null) {
      book = <Book>[];
      json['book'].forEach((v) {
        book!.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  String? pdf;

  Book({this.pdf});

  Book.fromJson(Map<String, dynamic> json) {
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdf'] = this.pdf;
    return data;
  }
}
