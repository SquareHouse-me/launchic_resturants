import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/view/profileView/profile_view.dart';

class AccountingSettings extends StatefulWidget {
  const AccountingSettings({super.key});

  @override
  State<AccountingSettings> createState() => _AccountingSettingsState();
}

class _AccountingSettingsState extends State<AccountingSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? name, id, email, phoneNumber;
  @override
  Widget build(BuildContext context) {
    id = Hive.box('userBox').get('restaurantId').toString();
    email = Hive.box('userBox').get('restaurantEmail').toString();
    phoneNumber = Hive.box('userBox').get('restaurantPhone').toString();
    name = Hive.box('userBox').get('restaurantName').toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'accountSettingText'.tr,
            style: CustomStyle.textSemiBold15,
          ),
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          ),
          backgroundColor: Colors.transparent,
          actions: [],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45.h,
              ),
              Text(
                'accountSettingText'.tr,
                style: CustomStyle.textBold36,
              ),
              SizedBox(
                height: 45.h,
              ),
              // CardList(
              //   title: 'Profile Update',
              //   onTap: () {
              //     Get.toNamed(RouteName.editProfilePage);
              //   },
              // ),
              CardList(
                title: 'Profile View',
                onTap: () {
                  Get.toNamed(RouteName.profileSettings);
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CardList(
                title: 'Password Update',
                onTap: () {
                  Get.toNamed(RouteName.changePasswordPage);
                },
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
