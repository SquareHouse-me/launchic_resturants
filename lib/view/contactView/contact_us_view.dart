import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0).copyWith(
        top: 100.h,
        left: 22.w,
        right: 22.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Contact Us',
          //   style: CustomStyle.textBold30.copyWith(
          //     color: AppColors.blackColor,
          //   ),
          // ),

          Text(
            'if you have any issue, please click on  the given below option ',
            style: CustomStyle.textRegular17.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
                backgroundColor: AppColors.goldenColor,
                child: Text(
                  '1',
                  style: CustomStyle.textRegular12.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                  ),
                )),
            title: Text(
              'call using local phone number',
              style: CustomStyle.textBold24.copyWith(
                color: AppColors.blackColor,
                fontSize: 15.sp,
              ),
            ),
            onTap: () {
              const url = "tel:+96599732998";
              launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
            },
            subtitle: Text(
              '+96598552651',
              style: CustomStyle.textRegular12.copyWith(
                color: Colors.grey,
                fontSize: 16.sp,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.phone,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
                backgroundColor: AppColors.goldenColor,
                child: Text(
                  '2',
                  style: CustomStyle.textRegular12.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                  ),
                )),
            title: Text(
              'call using Social Media',
              style: CustomStyle.textBold24.copyWith(
                color: AppColors.blackColor,
                fontSize: 15.sp,
              ),
            ),
            subtitle: Text('+96598552651',
                style: CustomStyle.textRegular12.copyWith(
                  color: Colors.grey,
                  fontSize: 16.sp,
                )),
            trailing: Icon(
              CupertinoIcons.phone_circle,
              color: Colors.green,
            ),
            onTap: () {
              const url =
                  "https://wa.me/96599732998?text=Hello I am restaurant owner";
              launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            },
          ),
        ],
      ),
    );
  }
}
