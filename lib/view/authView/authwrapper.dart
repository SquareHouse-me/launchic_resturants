import 'dart:developer';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/view/authView/signin_view.dart';
import 'package:restaurant/view/landingView/landing_view.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatefulWidget {
  AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (controller) {
        if (controller.isLogin.isEmpty) {
          log('user is Sign out or maybe first time');
         controller. checkAndRefreshToken();
          return SignInView();
        } else {
          controller.initControllers();
          log('user is SignInd ');
          return LandingView();
        }
      },
    );
  }
}
