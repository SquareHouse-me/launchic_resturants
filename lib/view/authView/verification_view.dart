import 'dart:async';
 
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:restaurant/animation/slidetransition_animation.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String pinCode = "";
  int timerDuration = 60;
  bool isTimerActive = false;
  bool isCompleted = false;
  String phoneNumber = '+*** ********';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // phoneNumber = Get.arguments[0];
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 71.w,
                top: 94.h,
              ),
              child: FadeInDown(
                child: Text(
                  'enterText'.tr,
                  style: CustomStyle.textBold36.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 27.w,
                right: 27.w,
                top: 16.h,
              ),
              child: FadeIn(
                child: Text(
                  'activationText'.tr + phoneNumber,
                  style: CustomStyle.textRegular15.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 27.w,
                right: 27.w,
                top: 57.h,
              ),
              child: PinCodeTextField(
                onSaved: (pin) {
                  if (kDebugMode) {
                    print("Pin entered: $pin");
                  }
                },
                onChanged: (pin) {
                  setState(() {
                    pinCode = pin;
                  });
                },
                hintStyle: CustomStyle.textRegular12
                    .copyWith(color: AppColors.whiteColor),
                autoFocus: true,
                animationCurve: Curves.bounceIn,
                cursorColor: AppColors.whiteColor,
                textStyle: CustomStyle.textRegular36.copyWith(
                  color: AppColors.whiteColor,
                ),
                showCursor: true,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  setState(() {
                    isCompleted = true;
                  });
                },
                pinTheme: PinTheme(
                  activeColor: AppColors.creamyColor,
                  borderWidth: 1.w,
                  inactiveBorderWidth: 1.w,
                  inactiveColor: AppColors.creamyColor,
                  borderRadius: BorderRadius.circular(13.r),
                  activeBorderWidth: 1.w,
                  activeFillColor: AppColors.creamyColor,
                  disabledColor: AppColors.creamyColor,
                  shape: PinCodeFieldShape.box,
                  inactiveFillColor: AppColors.creamyColor,
                  selectedFillColor: AppColors.whiteColor,
                  selectedColor: AppColors.whiteColor,
                  selectedBorderWidth: 1.w,
                  errorBorderWidth: 1.w,
                  errorBorderColor: Colors.redAccent,
                  disabledBorderWidth: 1.w,
                  fieldHeight: 64.h,
                  fieldWidth: 69.w,
                ),
                backgroundColor: Colors.transparent,
                appContext: context,
                length: 4,
              ),
            ),
            isCompleted
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SlideTransitionAnimation(
                      begin: const Offset(1.0, 1.0),
                      end: Offset.zero,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.h,
                        ).copyWith(bottom: 12.h, top: 12.h),
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: () {
                              Get.offNamed(RouteName.landingView);
                            },
                            childWidget:Text(
         'verifyText'.tr,
              style: CustomStyle.textSemiBold12.copyWith(
                color: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ) ,
                            bgColor: AppColors.creamyColor,
                            borderRadius: 8.r,
                            height: 48.h,
                            width: 327.w,
                            
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 100.w,
                    ),
                    child: InkWell(
                      onTap: () {
                        startTimer();
                      },
                      child: Text(
                        'Send code again 00:$timerDuration',
                        style: CustomStyle.textRegular12.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    if (!isTimerActive) {
      isTimerActive = true;
      updateTimer();
    }
  }

  void updateTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timerDuration > 0) {
        if (mounted) {
          setState(() {
            timerDuration -= 1;
          });
          updateTimer();
        }
      } else {
        isTimerActive = false;
        resetPinCode();
      }
    });
  }

  void resetPinCode() {
    if (mounted) {
      setState(() {
        pinCode = "";
        timerDuration = 60;
      });
    }
  }
}
