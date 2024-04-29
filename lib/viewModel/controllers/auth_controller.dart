import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/data/repositories/auth_repo.dart';
import 'package:restaurant/data/status.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/utils/utils.dart';
 import 'package:restaurant/viewModel/controllers/home_controller.dart';
import 'package:restaurant/viewModel/services/auth_services.dart';
import 'package:restaurant/viewModel/services/notification_services.dart';

class AuthController extends GetxController {
  Rx<AppStatus> appStatus = AppStatus.LOADING.obs;
  AuthServices _authServices = AuthServices();
  RxBool isLoading = false.obs;
  RxString errorText = ''.obs;
  void setIsLoading(bool _value) => isLoading.value = _value;
  void setAppStatus(AppStatus _value) => appStatus.value = _value;
  void setError(String _errorValue) => errorText.value = _errorValue;
  final _authRepo = AuthRepository();

  RxString isLogin = ''.obs;
NotificationServices services = NotificationServices();
  @override
  void onInit() { isLogin.value = Hive.box('userBox').get('token') ?? '';
     super.onInit();checkAndRefreshToken().then((value) {
     
     });
    
    
  }
  Future<void> checkAndRefreshToken() async {
    String? deviceToken = await services.getDeviceToken();

    // Retrieve the saved token and its timestamp
    var box = Hive.box('userBox');
    String? savedDeviceToken = box.get('DeviceToken');
    int? savedTokenTimestamp = box.get('TokenTimestamp');

    log('$savedDeviceToken savedDeviceToken');
    log('$deviceToken deviceToken');

    // Define a token expiration period, for example, 24 hours
    const tokenExpirationPeriod = Duration(hours: 24);
    bool isTokenExpired = savedTokenTimestamp == null ||
        DateTime.now().millisecondsSinceEpoch - savedTokenTimestamp >
            tokenExpirationPeriod.inMilliseconds;

    if (deviceToken == savedDeviceToken && !isTokenExpired) {
      log('Token is not expired. No need to refresh.');

      saveDeviceTokenMethod(
          saveToken: savedDeviceToken.toString());
    } else {
      log('Token is expired or different. Refreshing...');
      String newToken = await services
          .isTokenRefresh(); // This method needs to be synchronous or handle the refresh differently
      log('$newToken dd');
      saveDeviceTokenMethod(saveToken: newToken);
    }

    // _locationService.initLocationService();
  }
 Future<void> saveDeviceTokenMethod({
    required String saveToken,
  }) async {
    try {
      //  setAppStatus(AppStatus.LOADING);

      var bodyData = {
        "token": saveToken,
      };
      log(bodyData.toString());
      await _authRepo.saveDeviceToken(data: bodyData).then((value) async {
        if (value['statusCode'].toString() == '200') {
          log('${value['data']['message']} before checking');
          // fluttersToast(
          //     msg: value['data'].toString(),
          //     bgColor: AppColors.primaryColor,
          //     textColor: AppColors.darkGreyColor);
        } else {
          log('${value['message']} before checking');
           setIsLoading(false);
Hive.box('userBox').put('token', '');
          fluttersToast(
              msg: 'Session has been expired please login again',
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          _authServices.logoutUserData();
          
          Get.delete<HomeController>(force: true);

          isLogin.value = '';
          update();
        }
      }).onError((error, stackTrace) {
        // setAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('auth controller side try error' + e.toString());
    }
  }

  void initControllers() {
    Get.put(HomeController(), permanent: true);
  }

  Future<void> loginMethod(
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "email": email,
        "password": password,
      };
      await _authRepo.signInMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);

          Hive.box('userBox').put('token', value['data']['token']);
          isLogin.value = Hive.box('userBox').get('token').toString();
          log("isLogin :$isLogin");
          update();

          _authServices.logDataSave(responseData: value['data']);
          initControllers();
          fluttersToast(
              msg: 'User successfully SignIn',
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          Get.back();
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          log(value['data']['message'].toString());
          fluttersToast(
              msg: value['data']['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          fluttersToast(
              msg: value['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
        // fluttersToast(
        //     msg: error.toString(),
        //     bgColor: AppColors.primaryColor,
        //     textColor: AppColors.darkGreyColor)
        // ;
        log(error.toString());
      });
    } catch (e) {fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
      setIsLoading(false);
      log("error from loginMethod :" + e.toString());
    }
  }

  Future<void> forgotMethod({
    required String email,
  }) async {
    try {
      setIsLoading(true);
      final mapData = {
        "email": email,
      };
      await _authRepo.forgetMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          _authServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          Get.toNamed(RouteName.sendEmailCodeView, arguments: [
            email,
          ]);
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          _authServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
      log("error from forgot Method :" + e.toString());
    }
  }

  Future<void> resendCodeMethod({
    required String resetCodeToken,
  }) async {
    try {
      setIsLoading(true);
      final mapData = {
        "reset_code_token": resetCodeToken,
      };
      await _authRepo.resendCodeMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          _authServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);

          // Get.offNamed(RouteName.sendEmailCodeView, arguments: [
          //   resetCodeToken,
          // ]);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
      });
    } catch (e) {fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> resetPasswordMethod(
      {required String resetCodeToken,
      required String resetCode,
      required String password,
      required String passwordConfirmation}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "reset_code": resetCode,
        "reset_code_token": resetCodeToken,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
      await _authRepo.resetPasswordMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          // AuthServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.toNamed(RouteName.passChangedView, arguments: [false]);
          // Get.offNamed(RouteName.sendEmailCodeView, arguments: [
          //   resetCodeToken,
          // ]);
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
      });
    } catch (e) {fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> updatePassword(
      {required String password, required String passwordConfirmation}) async {
    try {
      setIsLoading(true);
      final mapData = {
        "password": password,
        "password_confirmation": passwordConfirmation
      };
      await _authRepo.updatePasswordMethod(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          // AuthServices.resetCodeTokenSave(responseData: value['data']);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.toNamed(RouteName.passChangedView, arguments: [true]);
          // Get.offNamed(RouteName.sendEmailCodeView, arguments: [
          //   resetCodeToken,
          // ]);
        } else if (value['statusCode'].toString() == '404') {
          setIsLoading(false);
          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        } else {
          log('else ' + value.toString());
          fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> logoutMethod() async {
    try {
      setIsLoading(true);

      await _authRepo.logout().then((value) async {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);

          fluttersToast(
              msg: value['data']['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          _authServices.logoutUserData();
          
          Get.delete<HomeController>(force: true);

          isLogin.value = '';
          update();
          Get.back<void>();

        }  else {
          log('else ' + value.toString());
           if( value['message'].toString()=='Unauthenticated.')
           {
             setIsLoading(false);
Hive.box('userBox').put('token', '');
          fluttersToast(
              msg: 'Session has been expired please login again',
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          _authServices.logoutUserData();
          
          Get.delete<HomeController>(force: true);

          isLogin.value = '';
          update();
          Get.back<void>();
           }else{
             fluttersToast(
              msg: value['message'],
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.back<void>();
          setIsLoading(false);
           }
         
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        setError(error.toString());
      });
    } catch (e) {
      setIsLoading(false);
      log("error from logout Method :" + e.toString());
    }
  }
}
