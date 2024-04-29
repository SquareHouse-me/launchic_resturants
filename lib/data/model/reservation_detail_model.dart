
 
enum OrderStatus { approved, pending, cancelled }
 
 class ReservationDetailModel {
  bool? success;
  int? statusCode;
  ReservationDetailList? data;

  ReservationDetailModel({this.success, this.statusCode, this.data});

  ReservationDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new ReservationDetailList.fromJson(json['data']) : null;
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

class ReservationDetailList {
  int? id;
  String? status;
  String? customer;
  String? bookingDate;
  String? bookingTime;
  String? partySize;
  int? total;
  dynamic  latitude;
   dynamic longitude;
  String? createdAt;
  Restaurant? restaurant;

  ReservationDetailList(
      {this.id,
      this.status,
      this.customer,
      this.bookingDate,
      this.bookingTime,
      this.partySize,
      this.total,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.restaurant});

  ReservationDetailList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    customer = json['customer'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    partySize = json['party_size'];
    total = json['total'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
