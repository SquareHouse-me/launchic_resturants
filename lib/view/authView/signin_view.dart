import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/generalWidgets/primarytext_button.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/view/authView/widget/remember_checkbox.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

import '../../routers/routers_name.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final auth = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  String iconPassword = AppIcons.eyeIcons;
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    top: 50.h,
                  ),
                  child: FadeInDown(
                    child: Text(
                      'loginText'.tr,
                      style: CustomStyle.textBold36
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 22.h,
                    ),
                    FadeIn(
                      child: Text(
                        'emailFieldText'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(onTapOutside: (p0) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.whiteColor,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        hintText: 'emailHintText'.tr,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              AppIcons.emailIcon,
                              width: 12.w,
                              height: 12.h,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                              .hasMatch(val)) {
                            return 'validEmail'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'passwordText'.tr,
                        style: CustomStyle.textMedium14.copyWith(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          RememberMeCheckbox(),
                      SizedBox(width: 40.w,),
                        Flexible(
                          child: PrimaryTextButton(
                            onPressed: () async {
                              Get.toNamed(RouteName.forgetView);
                            },
                            title: 'forgetText'.tr,
                           fontSize: 11.sp,
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(() => FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: auth.isLoading.value
                                ? () {
                                    log('message');
                                  }
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await auth.loginMethod(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
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
                                    'loginText'.tr,
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
