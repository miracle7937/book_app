class LegalTermsModel {
  bool? status;
  LegalTermsData? data;

  LegalTermsModel({this.status, this.data});

  LegalTermsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? new LegalTermsData.fromJson(json['data']) : null;
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

class LegalTermsData {
  String? gdpr;
  String? policy;
  String? copyrite;

  LegalTermsData({this.gdpr, this.policy, this.copyrite});

  LegalTermsData.fromJson(Map<String, dynamic> json) {
    gdpr = json['gdpr'];
    policy = json['policy'];
    copyrite = json['copyrite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gdpr'] = this.gdpr;
    data['policy'] = this.policy;
    data['copyrite'] = this.copyrite;
    return data;
  }
}
