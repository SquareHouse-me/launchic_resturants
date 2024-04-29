import 'dart:developer';

import 'package:restaurant/data/model/past_reservation_model.dart';
import 'package:restaurant/data/model/reservation_detail_model.dart';
import 'package:restaurant/data/model/reservation_model.dart';
import 'package:restaurant/data/network/network_api_services.dart';
import 'package:restaurant/res/app_urls.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  // Future<Restaurant> getAllRestaurants() async {
  //   String url = 'getAllRestaurantsApi';
  //   dynamic response =
  //       await _apiService.getApi(url: url, isHeaderRequired: false);
  //   return Restaurant.fromJson(response);
  // }

  // Future<MyData> getCurrentRestaurantData({required String id}) async {
  //   String url = 'detailApi' + id;

  //   dynamic response =
  //       await _apiService.getApi(url: url, isHeaderRequired: false);

  //   return MyData.fromJson(response['data']);
  // }
  Future<dynamic> getAllUpComingReservation() async {
    String url = getAllReservations;
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> getCurrentUpComingReservation({required String id}) async {
    String url = getAllReservations + "/$id";
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> getCancelCurrentReservation({required String id}) async {
    String url = getAllReservations + "/$id" + "/cancel";
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> getApprovedCurrentReservation({required String id}) async {
    String url = getAllReservations + "/$id" + "/approved";
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> getPastReservation() async {
    String url = pastApprovedReservationsApi;
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> getAllCancelledPastReservation() async {
    String url = pastCancelledReservationsApi;
    dynamic response =
        await _apiService.getApi(url: url, isHeaderRequired: true);
    return response;
  }

  Future<dynamic> updateEditProfile({required data}) async {
    String url = ProfileUpdateApi;

    dynamic response =
        await _apiService.putApi(url: url, isHeaderRequired: true, data: data);

    return response;
  }

  Future<dynamic> contactUsMethod({required var data}) async {
    String url = contactUsApi;
    dynamic response = await _apiService.postApi(
        url: url, isHeaderRequired: false, data: data);

    return response;
  }

 
  Future<dynamic> forceFullyUpdate() async {
    try {
      dynamic response = await _apiService.getApi(
          url: updateForceFullyApi, isHeaderRequired: false);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> phoneNumberRepo() async {
    try {
      String url = phoneNumbersApi;
      log(url);
      dynamic response =
          await _apiService.getApi(url: url, isHeaderRequired: false);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
