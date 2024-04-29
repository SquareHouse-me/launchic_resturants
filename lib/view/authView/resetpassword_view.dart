import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  String token = '', codeToken = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = Get.arguments[0];
    codeToken = Get.arguments[1];
  }

  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FadeInLeft(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                AppIcons.leftArrow,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
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
                      'resetPasswordTitle'.tr,
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
                      'resetDescription'.tr,
                      style: CustomStyle.textRegular15.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    FadeIn(
                      child: Text(
                        'createPasswordFieldText'.tr,
                        style: CustomStyle.textRegular12.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => PrimaryTextField(
                          onTapOutside: (p0) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          enabledBorder: AppColors.lightGreyColor,
                          focusedBorder: AppColors.whiteColor,
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                          hintText: 'passwordText'.tr,
                          obscureText: auth.obscurePassword.value,
                          keyboardType: TextInputType.text,
                          prefixIcon: FadeIn(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                AppIcons.lockIcons,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              auth.obscurePassword.value =
                                  !auth.obscurePassword.value;

                              if (auth.obscurePassword.value) {
                                auth.iconPassword.value = AppIcons.eyeIcons;
                              } else {
                                auth.iconPassword.value = AppIcons.eyeOpenIcon;
                              }
                            },
                            child: FadeIn(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  auth.iconPassword.value,
                                  width: 12.w,
                                  height: 12.h,
                                  color: AppColors.creamyColor,
                                ),
                              ),
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'validatorText'.tr;
                            }
                            if (val.length < 8) {
                              return 'charactersPassHintText'.tr;
                            }
                            return null;
                          },
                        )),
                    FadeIn(
                      child: Text(
                        'confirmPassFieldText'.tr,
                        style: CustomStyle.textRegular12.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => PrimaryTextField(
                          onTapOutside: (p0) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          enabledBorder: AppColors.lightGreyColor,
                          focusedBorder: AppColors.whiteColor,
                          textInputAction: TextInputAction.next,
                          controller: confirmController,
                          hintText: 'repeatPassHintText'.tr,
                          obscureText: auth.obscureConfirmPassword.value,
                          keyboardType: TextInputType.text,
                          prefixIcon: FadeIn(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                AppIcons.lockIcons,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              auth.obscureConfirmPassword.value =
                                  !auth.obscureConfirmPassword.value;

                              if (auth.obscureConfirmPassword.value) {
                                auth.iconConfirmPassword.value = AppIcons.eyeIcons;
                              } else {
                               auth. iconConfirmPassword.value = AppIcons.eyeOpenIcon;
                              }
                            },
                            child: FadeIn(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  auth.iconConfirmPassword.value,
                                  width: 12.w,
                                  height: 12.h,
                                  color: AppColors.creamyColor,
                                ),
                              ),
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'validatorText'.tr;
                            }
                            if (val != passwordController.text) {
                              return 'passwordMatchText'.tr;
                            }
                            return null;
                          },
                        )),
                    SizedBox(
                      height: 4.h,
                    ),
                    Obx(() => FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: auth.isLoading.value
                                ? () async {
                                    log('message');
                                  }
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await auth.resetPasswordMethod(
                                          resetCodeToken: token,
                                          resetCode: codeToken,
                                          password: passwordController.text
                                              .trim()
                                              .toString(),
                                          passwordConfirmation:
                                              confirmController.text.trim());
                                    }
                                  },
                            childWidget: auth.isLoading.value
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Center(
                                      child: CircularProgressIndicator.adaptive(
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
                                    'resetBtnText'.tr,
                                    style: CustomStyle.textSemiBold12.copyWith(
                                      color: AppColors.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            bgColor: AppColors.primaryColor,
                            borderRadius: 8.r,
                            height: 48.h,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
