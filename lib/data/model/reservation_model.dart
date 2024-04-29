 
class ReservationModel {
  bool? success;
  int? statusCode;
  List<MyReservationList>? data;

  ReservationModel({this.success, this.statusCode, this.data});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <MyReservationList>[];
      json['data'].forEach((v) {
        data!.add(new MyReservationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyReservationList {
  int? id;
  String? status;
  String? customer;
  String? bookingDate;
  String? bookingTime;
  String? partySize;
  int? total;
  dynamic uuid;
  String? createdAt;

  MyReservationList(
      {this.id,
      this.status,
      this.customer,
      this.bookingDate,
      this.bookingTime,
      this.partySize,
      this.total,
      this.uuid,
      this.createdAt});

  MyReservationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    customer = json['customer'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    partySize = json['party_size'];
    total = json['total'];
    uuid = json['uuid'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['customer'] = this.customer;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['party_size'] = this.partySize;
    data['total'] = this.total;
    data['uuid'] = this.uuid;
    data['created_at'] = this.createdAt;
    return data;
  }
}
