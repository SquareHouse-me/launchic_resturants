import 'dart:developer';

 
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String iconPassword = AppIcons.eyeIcons;
  String iconCPassword = AppIcons.eyeIcons;
  bool obscurePassword = true;
  bool obscureCPassword = true;
  String countryCode = '';
  String countryEmoji = '';

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 21.w,
                    right: 71.w,
                  ),
                  child: FadeInDown(
                    child: Text(
                      'Update Password'.tr,
                      style: CustomStyle.textBold36.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeIn(
                        child: Text(
                          'passwordFieldText'.tr,
                          style: CustomStyle.textMedium14.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextField(onTapOutside: (p0) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
                        styleColor: AppColors.blackColor,
                        hintColor: AppColors.blackColor,
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        hintText: 'passwordFieldText'.tr,
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              AppIcons.lockIcons,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
      
                              if (obscurePassword) {
                                iconPassword = AppIcons.eyeIcons;
                              } else {
                                iconPassword = AppIcons.eyeOpenIcon;
                              }
                            });
                          },
                          child: FadeIn(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                iconPassword,
                                width: 12.w,
                                height: 12.h,
                                color: AppColors.blackColor,
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
                      ),
                      FadeIn(
                        child: Text(
                          'passwordConfirmFieldText'.tr,
                          style: CustomStyle.textMedium14.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextField(onTapOutside: (p0) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
                        hintColor: AppColors.blackColor,
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: passwordConfirmController,
                        styleColor: AppColors.blackColor,
                        hintText: 'passwordConfirmFieldText'.tr,
                        obscureText: obscureCPassword,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              AppIcons.lockIcons,
                              width: 12.w,
                              height: 12.h,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureCPassword = !obscureCPassword;
      
                              if (obscureCPassword) {
                                iconCPassword = AppIcons.eyeIcons;
                              } else {
                                iconCPassword = AppIcons.eyeOpenIcon;
                              }
                            });
                          },
                          child: FadeIn(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                iconCPassword,
                                width: 12.w,
                                height: 12.h,
                                color: AppColors.blackColor,
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
                          if (passwordController.text != val) {
                            return 'passwordCheck'.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Obx(() => FadeInUp(
                            from: 20,
                            duration: const Duration(milliseconds: 800),
                            child: PrimaryButton(
                              elevation: 0,
                              onTap: authController.isLoading.value
                                  ? () {
                                      // authController.setIsLoading(false);
                                      log('message');
                                    }
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        // Get.offNamed(RouteName.landingView);
                                        await authController.updatePassword(
                                            password:
                                                passwordController.text.trim(),
                                            passwordConfirmation:
                                                passwordConfirmController.text
                                                    .trim());
                                      }
                                    },
                              childWidget: authController.isLoading.value
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    strokeWidth:
                                        2.0, // Adjust the thickness of the indicator
      
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.whiteColor),
                                  ),
                                ),
                                    )
                                  : Text(
                                      'update'.tr,
                                      style: CustomStyle.textSemiBold12.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              bgColor: AppColors.blackColor,
                              borderRadius: 8.r,
                              height: 50.h,
                              width: 327.w,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
