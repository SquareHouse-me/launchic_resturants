// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
 
class RememberMeCheckbox extends StatelessWidget {
    RememberMeCheckbox({Key? key}) : super(key: key);
 
RxBool isChecked=false.obs;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Obx(() => Checkbox(
            checkColor: Colors.black,
            activeColor: AppColors.whiteColor,
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red; // Text color when pressed
              }
              return Colors.white; // Default text color
            }),
            overlayColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red; // Text color when pressed
              }
              return Colors.blue; // Default text color
            }),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.r)),
            value: isChecked.value,
            onChanged: (onChange) {
              isChecked.value = onChange!;
            },
          )),
        ),
        SizedBox(
          width: 12.w,
        ),
        Obx(() => Text(
              'rememberText'.tr,
              style: CustomStyle.textMedium14.copyWith(
                color:
                    isChecked.value ? AppColors.whiteColor : Colors.white,
              ),
            )),
      ],
    );
  }
}
