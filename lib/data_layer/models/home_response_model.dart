class HomeResponseModel {
  bool? status;
  HomeData? data;

  HomeResponseModel({this.status, this.data});

  HomeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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

class HomeData {
  List<Slider>? slider;
  List<MyPlan>? myPlan;
  List<Latest>? latest;
  List<Collection>? collection;
  List<PopularModel>? popular;
  List<Viewd>? viewd;

  HomeData(
      {this.slider,
      this.myPlan,
      this.latest,
      this.collection,
      this.popular,
      this.viewd});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(new Slider.fromJson(v));
      });
    }
    if (json['my_plan'] != null) {
      myPlan = <MyPlan>[];
      json['my_plan'].forEach((v) {
        myPlan!.add(new MyPlan.fromJson(v));
      });
    }
    if (json['latest'] != null) {
      latest = <Latest>[];
      json['latest'].forEach((v) {
        latest!.add(new Latest.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
    if (json['popular'] != null) {
      popular = <PopularModel>[];
      json['popular'].forEach((v) {
        popular!.add(new PopularModel.fromJson(v));
      });
    }
    if (json['viewd'] != null) {
      viewd = <Viewd>[];
      json['viewd'].forEach((v) {
        viewd!.add(new Viewd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    if (this.myPlan != null) {
      data['my_plan'] = this.myPlan!.map((v) => v.toJson()).toList();
    }
    if (this.latest != null) {
      data['latest'] = this.latest!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.popular != null) {
      data['popular'] = this.popular!.map((v) => v.toJson()).toList();
    }
    if (this.viewd != null) {
      data['viewd'] = this.viewd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slider {
  String? images;
  String? url;

  Slider({this.images, this.url});

  Slider.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['url'] = this.url;
    return data;
  }
}

class MyPlan {
  int? status;
  String? subscribeAt;
  int? daysRemaining;
  String? expiresAt;

  MyPlan({this.status, this.subscribeAt, this.daysRemaining, this.expiresAt});

  MyPlan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subscribeAt = json['subscribe_at'];
    daysRemaining = json['days_remaining'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['subscribe_at'] = this.subscribeAt;
    data['days_remaining'] = this.daysRemaining;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}

class Latest {
  int? id;
  String? title;
  String? images;
  String? audio;

  Latest({this.id, this.title, this.images, this.audio});

  Latest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    images = json['images'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['images'] = this.images;
    data['audio'] = this.audio;
    return data;
  }
}

class Collection {
  int? id;
  String? title;

  Collection({this.id, this.title});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Viewd {
  int? id;
  String? title;
  String? images;

  Viewd({this.id, this.title, this.images});

  Viewd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['images'] = this.images;
    return data;
  }
}

class PopularModel {
  int? id;
  String? title;
  String? author;
  String? description;
  String? images;

  PopularModel(
      {this.id, this.title, this.author, this.description, this.images});

  PopularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}
