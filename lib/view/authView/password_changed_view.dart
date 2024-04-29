import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/animation/scaletransition_animation.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:shimmer/shimmer.dart';

class PassChangedView extends StatefulWidget {
  const PassChangedView({super.key});

  @override
  State<PassChangedView> createState() => _PassChangedViewState();
}

class _PassChangedViewState extends State<PassChangedView> {
  bool isUpdatePassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUpdatePassword = Get.arguments[0];
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: AppColors.halfWhiteColor,
                child: ScalesTransitionAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 55.h,
                      bottom: 24.h,
                    ),
                    child: SvgPicture.asset(AppIcons.starIcons),
                  ),
                ),
              ),
              FadeInDown(
                child: Text(
                  'passChangeText'.tr,
                  style: CustomStyle.textBold30.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 16.h,
                ),
                child: FadeIn(
                  child: Text(
                    'successPassDes'.tr,
                    style: CustomStyle.textRegular16.copyWith(
                      color: AppColors.creamyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 800),
                child: PrimaryButton(
                  elevation: 0,
                  onTap: () {
                    if (isUpdatePassword) {
                      Get.close(3);
                    } else {
                      Get.close(4);
                    }
                  },
                  childWidget: Text(
                    isUpdatePassword ? 'Back to Home' : 'loginBtnText'.tr,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
