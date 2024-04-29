// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:restaurant/res/colors.dart';

import 'package:restaurant/routers/routers.dart';
import 'package:restaurant/view/authView/authwrapper.dart';
import 'package:restaurant/view/langauges/langauges.dart';
 import 'package:restaurant/view/onBoardingView/onboard_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(message.notification!.title.toString() + ' MessagingBackground');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
  ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  await Hive.openBox('box');
  await Hive.openBox('userBox');
  final isFirstTime = Hive.box('box').get('isFirstTime') ?? true;
  print(isFirstTime);

  final String languageCode = Hive.box('box').get('lang_code') ?? '';
  final String local = Hive.box('box').get('local') ?? '';

  runApp(MyApp(
    languageCode: languageCode,
    local: local,
    isFirstTime: isFirstTime,
  ));
}

class MyApp extends StatelessWidget {
  final String languageCode, local;
  final bool isFirstTime;

  const MyApp(
      {super.key,
      required this.languageCode,
      required this.local,
      required this.isFirstTime});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant',
            translations: TransLanguage(),
            locale: languageCode == '' && local == ''
                ? Locale('en', 'US')
                : Locale(local, languageCode),
            theme: ThemeData(
              fontFamily: 'Cairo',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Cairo'),
              dialogBackgroundColor: AppColors.whiteColor,
              dialogTheme: DialogTheme(
                backgroundColor: AppColors.whiteColor,
                surfaceTintColor: AppColors.whiteColor,
              ),
              appBarTheme: AppBarTheme(surfaceTintColor: AppColors.whiteColor),
              canvasColor: Colors.transparent,
              datePickerTheme: DatePickerThemeData(
                backgroundColor: AppColors.whiteColor,
              ),

              // colorScheme: ColorScheme(
              //   primary: Color(0xFFFFFFFF), // <---- I set white color here

              //   secondary: Color(0xFFEFF3F3),

              //   background: Color(0xFFFFFFFF),
              //   surface: Color(0xFFFFFFFF),
              //   onBackground: Colors.white,

              //   onSecondary: Color(0xFFFFFFFF),
              //   onSurface: Color(0xFFFFFFFF),
              //   brightness: Brightness.light,
              //   onPrimary: AppColors.primaryColor,
              //   error: Colors.redAccent,
              //   onError: Colors.red,
              // ),
            ),
            getPages: AppRoutes.appRoute(),
            home: isFirstTime ? OnBoardingView() : AuthWrapper(),
          );
        });
  }
}
