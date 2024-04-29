import 'dart:async';
import 'dart:developer';

 
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:restaurant/animation/slidetransition_animation.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

class SendEmailCodeView extends StatefulWidget {
  const SendEmailCodeView({super.key});

  @override
  _SendEmailCodeViewState createState() => _SendEmailCodeViewState();
}

class _SendEmailCodeViewState extends State<SendEmailCodeView> {
   
  String email = 'helloword@gmail.com';
  String resetToken = '';  TextEditingController pinCodeC = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = Get.arguments[0];
    resetToken = Hive.box('userBox').get('reset_code_token').toString();
   auth. startTimer();
  }

  final auth = Get.find<AuthController>();
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 71.w,
                  top: 66.h,
                ),
                child: FadeInDown(
                  child: Text(
                    'sendCodeTitle'.tr,
                    style: CustomStyle.textBold36.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 27.w,
                  top: 16.h,
                ),
                child: FadeIn(
                  child: Text(
                    'sendCodeDes'.tr + email,
                    style: CustomStyle.textRegular15.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: PinCodeTextField(
                onSaved: (pin) {
                  if (kDebugMode) {
                    print("Pin entered: $pin");
                  }
                },
                onChanged: (pin) {
                   
                    auth.pinCode.value = pin;
                  
                },
                hintStyle: CustomStyle.textRegular12
                    .copyWith(color: AppColors.whiteColor),
                autoFocus: false,
                animationCurve: Curves.bounceIn,
                cursorColor: AppColors.whiteColor,
                textStyle: CustomStyle.textRegular36.copyWith(
                  color: AppColors.whiteColor,
                ),
                showCursor: true,
                autoUnfocus: true,
                autoDismissKeyboard: true,
                controller:  pinCodeC,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  
                    auth.isCompleted.value = true;
                 
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
              SizedBox(height: 25.h),
               Obx(() => auth.isCompleted.value?SlideTransitionAnimation(
                      begin: const Offset(1.0, 1.0),
                      end: Offset.zero,
                      child: Obx(() => FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            child: PrimaryButton(
                              elevation: 0,
                              onTap: auth.isLoading.value
                                  ? () {
                                      log('message');
                                    }
                                  : () async {
                                      Get.toNamed(RouteName.resetPasswordView,
                                          arguments: [resetToken, auth.pinCode.value]);
                                    },
                              childWidget: auth.isLoading.value
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Center(
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          backgroundColor: Colors.transparent,
                                          strokeWidth:
                                              2.0, // Adjust the thickness of the indicator

                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColors.blackColor),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'verifyText'.tr,
                                      style:
                                          CustomStyle.textSemiBold12.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              bgColor: AppColors.creamyColor,
                              borderRadius: 8.r,
                              height: 48.h,
                            ),
                          )),
                    ):Center(
                      child: InkWell(
                        onTap: () async {
                         auth. startTimer();
                          await auth.resendEmailVerifyCodeMethod(
                            resetCodeToken: resetToken,
                          );
                        },
                        child: Text(
                        'Send code again 00:${auth.timerDuration.value}',
                        style: CustomStyle.textRegular12.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      ),
                    ))
                     
            ],
          ),
        ),
      ),
    );
  }



}
