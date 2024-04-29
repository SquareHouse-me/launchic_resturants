// ignore_for_file: must_be_immutable

 
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';

class ThankYouDialog extends StatelessWidget {
  ThankYouDialog({
    Key? key,
  }) : super(key: key);

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
              child: SvgPicture.asset(
                AppIcons.thankyouIcon,
                width: 70.w,
                height: 70.h,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Thank you'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textSemiBold20,
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'your form has been submitted to restaurant owner'.tr,
              textAlign: TextAlign.center,
              style: CustomStyle.textRegular12,
            ),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(
              onTap: () {
                Get.back<void>();
              },
              childWidget: Text(
                'back'.tr,
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
            )
          ],
        ),
      ),
    );
  }
}
