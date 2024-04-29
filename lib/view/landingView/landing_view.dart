import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant/animation/auto_shake_animation.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/view/contactView/contact_us.dart';
import 'package:restaurant/view/contactView/contact_us_view.dart';
import 'package:restaurant/view/eventView/presentEvents/present_reservation.dart';
import 'package:restaurant/view/profileView/profile_view.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/view/dashboardView/home_view.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  int _currentIndex = 0;
  final HomeController homeC = Get.find<HomeController>();

  List<Widget> pages = [
    DashBoardView(),
    PresentReservation(),
    ContactUs(),
    const ProfileView()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeC.getAllPastReservation();
  }

  @override
  build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        extendBody: true,
        appBar: _currentIndex == 0
            ? AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
                toolbarHeight: 40.h,
                backgroundColor: Colors.transparent,
                actions: [
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        _currentIndex = 1;
                      });
                      //   FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
                      //  await firebaseFirestore.collection('myUser').doc('56756756').set({'data':'tyrtyt'});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 40.w, top: 12.h),
                      child: Badge(
                        alignment: Alignment.topRight,
                        backgroundColor: AppColors.goldenColor,
                        label: Obx(() => Text(homeC
                            .pendingReservationList.value.length
                            .toString())),
                        child: Icon(
                          Icons.notification_important_outlined,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : null,
        body: Padding(
          padding: EdgeInsets.only(bottom: 60.h),
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColors.light80GreyColor,
              offset: const Offset(
                8.0,
                8.0,
              ),
              blurRadius: 20,
              spreadRadius: 12.0,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(12.0)
                .copyWith(left: 0.w, right: 0.w, bottom: 0.w),
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.blackColor,
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              iconSize: 24.sp,
              // selectedLabelStyle: textTheme.bodySmall!
              //     .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
              // unselectedLabelStyle: textTheme.bodySmall!
              //     .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
              currentIndex: _currentIndex,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      AppIcons.homeOutline,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  label: '',
                  activeIcon: CustomShakeAnimation(
                    begin: '-5.0',
                    end: '5.0',
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: SvgPicture.asset(
                        AppIcons.homeFilltor,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      AppIcons.calendarOutline,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  label: '',
                  activeIcon: CustomShakeAnimation(
                    begin: '-5.0',
                    end: '5.0',
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: SvgPicture.asset(
                        AppIcons.calendarFill,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      AppIcons.PhoneIcon,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  label: '',
                  activeIcon: CustomShakeAnimation(
                    begin: '-5.0',
                    end: '5.0',
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: SvgPicture.asset(
                        AppIcons.PhoneIcon,
                        color: AppColors.lightGreyColor,
                      ),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      AppIcons.profileOutline,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  label: '',
                  activeIcon: CustomShakeAnimation(
                    begin: '-5.0',
                    end: '5.0',
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: SvgPicture.asset(
                        AppIcons.profileFill,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
