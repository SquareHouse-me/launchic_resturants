import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/animation/slidetransition_animation.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';

import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/view/authView/authwrapper.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      AssetImage('assets/images/LandingScreen.png'),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/LandingScreen.png',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: 250.0.h,
            left: 86.0.w,
            right: 86.0.w,
            child: SlideTransitionAnimation(
              begin: Offset(1.0.w, 1.0.w),
              end: Offset.zero,
              child: FadeInUp(
                child: SvgPicture.asset(AppIcons.textIconSvg),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0.r),
            topRight: Radius.circular(20.0.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeInDown(
              from: 20,
              delay: const Duration(milliseconds: 100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.0.h,
                  horizontal: 21.0.w,
                ),
                child: Text(
                  'landingViewText'.tr,
                  textAlign: TextAlign.center,
                  style: CustomStyle.textSemiBold20.copyWith(fontSize: 20.sp),
                ),
              ),
            ),
            FadeInUp(
              from: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.0.h,
                  horizontal: 21.0.w,
                ).copyWith(bottom: 30.0.h, top: 16.0.h),
                child: PrimaryButton(
                  elevation: 0,
                  onTap: () { Hive.box('box').put('isFirstTime', false);
                    Get.off(()=>AuthWrapper());},
                
                  bgColor: AppColors.primaryColor,
                  borderRadius: 8.0.r,
                  height: 48.0.h,
                    childWidget: Text(
                   'landingBtnText'.tr,
                    style: CustomStyle.textSemiBold12.copyWith(
                      color:   AppColors.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
