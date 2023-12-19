class ContactUsModel {
  bool? status;
  ContactData? data;

  ContactUsModel({this.status, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ContactData.fromJson(json['data']) : null;
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

class ContactData {
  String? phoneNo;
  String? email;

  ContactData({this.phoneNo, this.email});

  ContactData.fromJson(Map<String, dynamic> json) {
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    return data;
  }
}
