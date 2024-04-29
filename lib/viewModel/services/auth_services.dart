import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class AuthServices {
  logDataSave({required Map responseData}) {
    // log(responseData['customer'].toString());
    Hive.box('userBox').put('token', responseData['token']);
    Hive.box('userBox').put('restaurantId', responseData['user']['id']);
    Hive.box('userBox').put('restaurantName', responseData['user']['name']);
    Hive.box('userBox').put('restaurantEmail', responseData['user']['email']);
    Hive.box('userBox').put('restaurantPhone', responseData['user']['phone']);
    Hive.box('userBox').put('restaurantLogo', responseData['user']['logo']);
        Hive.box('userBox').put('restaurantTables', responseData['user']['no_of_tables']??'0');
     
        Hive.box('userBox').put('restaurantLocation', responseData['user']['location'] );
             Hive.box('userBox').put('restaurantAvailability', responseData['user']['availability'] );   
          // Hive.box('userBox').put('restaurantAvailability', responseData['user']['availability'] );   
        
         log("user-Toke : "+Hive.box('userBox').get('token').toString() +
        " id :   " +
        Hive.box('userBox').get('restaurantId').toString() +
        "  email : " +
        Hive.box('userBox').get('restaurantEmail').toString() +
        " logo :  " +
        Hive.box('userBox').get('restaurantLogo').toString() +
        "Phone : " +
        Hive.box('userBox').get('restaurantPhone').toString() +
        "restaurant-Tables : " +
        Hive.box('userBox').get('restaurantTables').toString() +
        "Location : " +
        Hive.box('userBox').get('restaurantLocation').toString() +
        "restaurant-Availability : " +
        Hive.box('userBox').get('restaurantAvailability').toString());
    ;
  }

  resetCodeTokenSave({required Map responseData}) {
    // log(responseData['customer'].toString());
    Hive.box('userBox')
        .put('reset_code_token', responseData['reset_code_token']);

    log(Hive.box('userBox').get('reset_code_token').toString());
  }

  logoutUserData() {
    Hive.box('userBox').clear();
  }

  updateUserInfo({required var responseData}) {
    log('update User data :' + responseData.toString());
    Hive.box('userBox').put('restaurantName', responseData['name']);
    Hive.box('userBox').put('restaurantEmail', responseData['email']);
    Hive.box('userBox').put('restaurantPhone', responseData['phone']);
  }
}
