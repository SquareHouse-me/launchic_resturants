import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? name, id, email, phoneNumber, location, available;
  @override
  Widget build(BuildContext context) {
    id = Hive.box('userBox').get('restaurantId').toString();
    email = Hive.box('userBox').get('restaurantEmail').toString();
    phoneNumber = Hive.box('userBox').get('restaurantPhone').toString();
    name = Hive.box('userBox').get('restaurantName').toString();
    location = Hive.box('userBox').get('restaurantLocation').toString();
    available = Hive.box('userBox').get('restaurantAvailability').toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile View'.tr,
            style: CustomStyle.textSemiBold15,
          ),
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(RouteName.editProfilePage);
              },
              icon: SvgPicture.asset(
                AppIcons.editSquare,
                color: AppColors.blackColor,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 33.h,
              ),
              Text(
                'Profile View'.tr,
                style: CustomStyle.textBold36,
              ),
              SizedBox(
                height: 33.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'nameText'.tr,
                  style: CustomStyle.textSemiBold15,
                ),
                subtitle: Text(
                  name ?? "Sarah Al-bloshi",
                  style: CustomStyle.textRegular15,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'emailText'.tr,
                  style: CustomStyle.textSemiBold15,
                ),
                subtitle: Text(
                  email ?? "s.alboshi@gmail.com",
                  style: CustomStyle.textRegular15,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'phoneText'.tr,
                  style: CustomStyle.textSemiBold15,
                ),
                subtitle: Text(
                  phoneNumber ?? '+ 96598552651',
                  style: CustomStyle.textRegular15,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Location'.tr,
                  style: CustomStyle.textSemiBold15,
                ),
                subtitle: Text(
                  location ?? 'empty',
                  style: CustomStyle.textRegular15,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Availability Status'.tr,
                  style: CustomStyle.textSemiBold15,
                ),
                subtitle: Text(
                  available ?? 'empty',
                  style: CustomStyle.textRegular15,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
