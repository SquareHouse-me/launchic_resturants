// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';

class LogOutDialog extends StatelessWidget {
  LogOutDialog({
    Key? key,
  }) : super(key: key);
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      titlePadding: EdgeInsets.zero,
      backgroundColor: AppColors.whiteColor,
      content: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                Icons.logout,
                size: 56.sp,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'logoutTitle'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textSemiBold20,
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'logoutDes'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textRegular12,
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => PrimaryButton(
                  onTap: authController.isLoading.value
                      ? () async {
                          log('message');
                        }
                      : () async {
                          await authController.logoutMethod();
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
                          'logoutText'.tr,
                          style: CustomStyle.textSemiBold12.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  bgColor: AppColors.blackColor,
                  borderRadius: 67.r,
                  height: 62.h,
                  elevation: 0,
                )),
          ],
        ),
      ),
    );
  }
}
