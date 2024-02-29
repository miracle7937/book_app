import 'home_response_model.dart';

class UserResponse {
  bool status;
  String message;
  UserData data;
  List<Plan?>? plans;

  UserResponse({
    required this.status,
    required this.data,
    required this.message,
    required this.plans,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'],
      message: json['message'],
      plans: json['plans'] == null
          ? null
          : List<Plan>.from(json['plans'].map((plan) => Plan.fromJson(plan))),
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      "plans": plans?.map((plan) => plan?.toJson()).toList(),
    };
  }
}

class UserData {
  int? id;
  String? email;
  String? gender;
  String? firstName;
  String? lastName;
  num? wallet;
  String? deviceId;
  int? isEmailVerified;
  int? code;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;
  MyPlan? myPlan;
  List<String>? abusiveWords;
  List<String>? inAppIosPurchase;
  List<UserCard?>? savedCard;

  UserData(
      {this.id,
      this.email,
      this.gender,
      this.firstName,
      this.lastName,
      this.wallet,
      this.deviceId,
      this.isEmailVerified,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.myPlan,
      this.savedCard,
      this.abusiveWords,
      this.inAppIosPurchase});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        email: json['email'],
        gender: json['gender'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        wallet: json['wallet'],
        deviceId: json['device_id'],
        isEmailVerified: json['is_email_verified'],
        code: json['code'],
        status: json['status'],
        token: json['token'],
        myPlan:
            json['my_plan'] == null ? null : MyPlan.fromJson(json['my_plan']),
        savedCard: json['saved_card'] == null
            ? null
            : List<UserCard>.from(
                json['saved_card'].map((plan) => UserCard.fromJson(plan))),
        abusiveWords: json['abusive_words'] == null
            ? []
            : (json["abusive_words"] as List).map((e) => e.toString()).toList(),
        inAppIosPurchase: json['inapp_ios_purchase'] == null
            ? []
            : (json["inapp_ios_purchase"] as List)
                .map((e) => e.toString())
                .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'gender': gender,
      'first_name': firstName,
      'last_name': lastName,
      'wallet': wallet,
      'device_id': deviceId,
      'is_email_verified': isEmailVerified,
      'code': code,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'token': token,
      'my_plan': myPlan?.toJson(),
      'abusive_words': abusiveWords,
      'inapp_ios_purchase': inAppIosPurchase,
      'saved_card': savedCard?.map((e) => e?.toJson()).toList(),
    };
  }
}

class Plan {
  int id;
  String title;
  String amount;
  String period;

  Plan({
    required this.id,
    required this.title,
    required this.amount,
    required this.period,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      period: json['period'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'period': period,
    };
  }
}

class UserCard {
  int? id;
  String? customerId;
  String? brand;
  String? last4;
  String? expMonth;
  String? expYear;
  String? name;

  UserCard(
      {this.id,
      this.customerId,
      this.brand,
      this.last4,
      this.expMonth,
      this.expYear,
      this.name});

  UserCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    brand = json['brand'];
    last4 = json['last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['brand'] = this.brand;
    data['last4'] = this.last4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['name'] = this.name;
    return data;
  }
}
