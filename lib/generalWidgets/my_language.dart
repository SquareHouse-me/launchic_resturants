 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/res/colors.dart';

class MySelectLanguage extends StatelessWidget {
  const MySelectLanguage({
    super.key,
    required this.image,
    required this.text,
    required this.color,
    required this.onTab,
  });
  final String image;
  final VoidCallback onTab;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                child: Image.asset(
              image,
              height: 25.h,
            )),
            Text(text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 17.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.right),
          ],
        ),
      ),
    );
  }
}
