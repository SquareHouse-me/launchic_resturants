// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/animation/scaletransition_animation.dart';
import 'package:restaurant/generalWidgets/logout_dialog.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  AnimationController? _controller;
  AnimationController? controller;
  final GlobalKey<AnimatedListState> _listkey = GlobalKey<AnimatedListState>();

  List<Widget> newList = [];
  void addData() {
    Future ft = Future(() {});
    reUsableList.forEach((var resList) {
      ft = ft.then((value) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          newList.add(
            CardList(
              title: resList['title'],
              onTap: resList['onPressed'],
            ),
          );
          _listkey.currentState?.insertItem(newList.length - 1);
        });
      });
    });
  }

  String photoUrl = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addData();
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    photoUrl = Hive.box('userBox').get('restaurantLogo') ?? '';
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: AppColors.halfWhiteColor,
              loop: 2,
              child: Text(
                'profileText'.tr,
                style: CustomStyle.textBold24,
              ),
            ),
            ScalesTransitionAnimation(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 12.h,
                ),
                child: Container(
                  width: 140.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGrey12Color,
                      image: photoUrl.isEmpty
                          ? DecorationImage(
                              image:
                                  AssetImage('assets/images/placeholder.png'),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                photoUrl,
                              ),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: reUsableList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 600),
                    position: index,
                    child: ScaleAnimation(
                      scale: 0.8,
                      child: FadeInAnimation(
                        curve: Curves.easeIn,
                        child: CardList(
                          title: reUsableList[index]['title'],
                          onTap: reUsableList[index]['onPressed'],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.dialog(LogOutDialog());
                },
                child: Container(
                  width: 98.w,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Color(0XFFEEEEEE)),
                  child: Center(
                    child: Text(
                      'lgOutText'.tr,
                      style: CustomStyle.textSemiBold15.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> reUsableList = [
    {
      'title': 'reservationText'.tr,
      'onPressed': () {
        Get.toNamed(RouteName.pastReservationScreen);
      },
    },
    {
      'title': 'accountSettings'.tr,
      'onPressed': () {
        Get.toNamed(RouteName.accountingSettings);
      }
    },
    {
      'title': 'contactText'.tr,
      'onPressed': () {
        Get.toNamed(RouteName.contactUs);
      }
    },
  ];
}

class CardList extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const CardList({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 315.w,
        height: 56.h,
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.only(top: 4.h),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: AppColors.light80GreyColor,
                offset: const Offset(
                  0.0,
                  0.1,
                ),
                blurRadius: 23,
                spreadRadius: 10.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 155.w,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  title,
                  style: CustomStyle.textRegular17,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
