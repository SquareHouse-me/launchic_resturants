 
import 'package:flutter/material.dart';
 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
 import 'package:url_launcher/url_launcher.dart';
 
import 'primary_button.dart';

class UpgradeDialog {
  static Future<void> showLocationDialog(BuildContext context, String url) async {
    
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
      canPop: false,
          child: AlertDialog(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
            titlePadding: EdgeInsets.zero,
            backgroundColor: AppColors.whiteColor,
            content: Container(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        AppIcons.upgradeIcon,
                        width: 45.w,
                        height: 45.w,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Alerting Users to New App Versions'.tr,
                      textAlign: TextAlign.center,
                      style: CustomStyle.textSemiBold20,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'Effortlessly keep your app up-to-date with a concise in-app alert for new versions, enhancing features and security with ease.'.tr,
                      textAlign: TextAlign.center,
                      style: CustomStyle.textRegular12,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                      
                     
                    Flexible(
                      child: PrimaryButton(
                        onTap: ()async { 
                        await launchWebURL(url);
                          Navigator.of(context).pop<void>();
                        },
                        childWidget: Text(
                          'Update Now'.tr,
                          style: CustomStyle.textSemiBold12.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        bgColor: AppColors.blackColor,
                        borderRadius: 67.r,
                        height: 45.h,
                        width: 60.w,
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
 
}
 Future<void> launchWebURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $urlString';
  }
}