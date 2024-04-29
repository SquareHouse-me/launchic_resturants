class ContactUsModel {
  bool? success;
  int? statusCode;
  ContactData? data;

  ContactUsModel(param0, {this.success, this.statusCode, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new ContactData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContactData {
  String? phone;
  String? whatsapp;

  ContactData({this.phone, this.whatsapp});

  ContactData.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
