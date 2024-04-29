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

class ForgetView extends StatefulWidget {
  const ForgetView({super.key});

  @override
  State<ForgetView> createState() => _ForgetViewState();
}

class _ForgetViewState extends State<ForgetView> {
  final emailController = TextEditingController();
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

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
                    right: 56.w,
                    top: 56.h,
                  ),
                  child: FadeInDown(
                    child: Text(
                      'forgetText'.tr,
                      style: CustomStyle.textBold36.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 35.w,
                    top: 19.h,
                  ),
                  child: FadeIn(
                    child: Text(
                      'forgetDescription'.tr,
                      style: CustomStyle.textRegular15.copyWith(
                        color: AppColors.light30GreyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    FadeIn(
                      child: Text(
                        'enterEmailText'.tr,
                        style: CustomStyle.textRegular12.copyWith(
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
                        hintText: 'enterEmailHintText'.tr,
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
                    SizedBox(
                      height: 7.h,
                    ),
                    Obx(() => FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 800),
                          child: PrimaryButton(
                            elevation: 0,
                            onTap: authController.isLoading.value
                                ? () {
                                    log('message');
                                  }
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await authController.forgotMethod(
                                          email:
                                              emailController.text.toString());
                                    }
                                  },
                            childWidget: authController.isLoading.value
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
                                    'sendText'.tr,
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
