import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
 
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:restaurant/data/app_exceptions.dart';
import 'package:restaurant/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(
      {required String url, required bool isHeaderRequired}) async {
    if (kDebugMode) {
      print(url);
    }

    try {
      dynamic responseJson;
      if (isHeaderRequired == true) {
        String token = Hive.box('userBox').get('token').toString();

        // creating header for post api
        final headerMap = {
          "Accept": "application/json",
          "Authorization": 'Bearer $token'
        };
        log(token);

        final response = await http
            .get(Uri.parse(url), headers: headerMap)
            .timeout(const Duration(seconds: 30));
        responseJson = returnResponse(response);
        // log("responseJson:  " + responseJson.toString());
        return responseJson;
      } else {
        final headerMap = {
          "Accept": "application/json",
        };

        final response = await http
            .get(Uri.parse(url), headers: headerMap)
            .timeout(const Duration(seconds: 30));
        responseJson = returnResponse(response);

        return responseJson;
      }
    } on SocketException {
      throw InternetException('internet is slow try again');
    } on RequestTimeOut {
      throw RequestTimeOut('internet is slow try again');
    }
  }

  @override
  Future<dynamic> postApi(
      {var data, required String url, required bool isHeaderRequired}) async {
    dynamic responseJson;

    try {
      if (isHeaderRequired) {
        String token = Hive.box('userBox').get('token').toString();

        // creating header for post api
        final headerMap = {
          "Accept": "application/json",
          "Authorization": 'Bearer $token'
        };
        log(token);
        // log(data.toString());
        // log(url.toString());
        final response = await http
            .post(
              Uri.parse(url),
              body: data,
              headers: headerMap,
            )
            .timeout(const Duration(seconds: 10));

        responseJson = returnResponse(response);
         
      } else {
        log(data.toString());
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ).timeout(const Duration(seconds: 10));
        // var repoData = jsonDecode(response.body);
        // print(repoData.toString() + 'response');
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }
  @override
  Future putApi({required data, required String url, required bool isHeaderRequired})async {
      dynamic responseJson;

    try {
      if (isHeaderRequired) {
        String token = Hive.box('userBox').get('token').toString();

        // creating header for post api
        final headerMap = {
          "Accept": "application/json",
          "Authorization": 'Bearer $token'
        };
        log(token);
        // log(data.toString());
        // log(url.toString());
        final response = await http
            .put(
              Uri.parse(url),
              body: data,
              headers: headerMap,
            )
            .timeout(const Duration(seconds: 10));

        responseJson = returnResponse(response);
         
      } else {
        log(data.toString());
        final response = await http.put(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ).timeout(const Duration(seconds: 10));
        // var repoData = jsonDecode(response.body);
        // print(repoData.toString() + 'response');
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw InternetException('');
    } on TimeoutException {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        // log('message'+ responseJson.toString());
        return responseJson;
      default:
        throw FetchDataException(
            'Error occurred while communicating with the server ${response.statusCode}   ${jsonDecode(response.body)}');
    }
  }
  

}
