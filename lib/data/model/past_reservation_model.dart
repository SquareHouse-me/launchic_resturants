 
class PastReservationsModel {
  bool? success;
  int? statusCode;
  List<PastList>? data;

  PastReservationsModel({this.success, this.statusCode, this.data});

  PastReservationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <PastList>[];
      json['data'].forEach((v) {
        data!.add(new PastList.fromJson(v));
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

class PastList {
  int? id;
  String? status;
  String? customer;
  String? bookingDate;
  String? bookingTime;
  String? partySize;
  dynamic total;
  dynamic uuid;
  String? createdAt;
  Restaurant? restaurant;

  PastList(
      {this.id,
      this.status,
      this.customer,
      this.bookingDate,
      this.bookingTime,
      this.partySize,
      this.total,
      this.uuid,
      this.createdAt,
      this.restaurant});

  PastList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    customer = json['customer'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    partySize = json['party_size'];
    total = json['total'];
    uuid = json['uuid'];
    createdAt = json['created_at'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
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
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    return data;
  }
}

class Restaurant {
  int? id;
  bool? newOpen;
  String? availability;
  int? noOfTables;
  String? name;
  String? email;
  String? phone;
  int? price;
  String? location;
  String? latitude;
  String? longitude;
  String? logo;
  String? banner;

  Restaurant(
      {this.id,
      this.newOpen,
      this.availability,
      this.noOfTables,
      this.name,
      this.email,
      this.phone,
      this.price,
      this.location,
      this.latitude,
      this.longitude,
      this.logo,
      this.banner});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newOpen = json['new_open'];
    availability = json['availability'];
    noOfTables = json['no_of_tables'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    price = json['price'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    logo = json['logo'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['new_open'] = this.newOpen;
    data['availability'] = this.availability;
    data['no_of_tables'] = this.noOfTables;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['price'] = this.price;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    return data;
  }
}
