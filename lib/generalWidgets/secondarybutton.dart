import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/res/typography.dart';

class SecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text, icons;

  final double height;
  final double borderRadius;

  final Color textColor, bgColor;
  final Color? iconColor;
  const SecondaryButton(
      {super.key,
      this.iconColor,
      required this.onTap,
      required this.text,
      required this.height,
      required this.icons,
      required this.borderRadius,
      required this.textColor,
      required this.bgColor});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 0.h)
            .copyWith(right: 50.w),
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.icons,
              color: widget.iconColor,
              width: 26.w,
              height: 26.h,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                widget.text,
                style: CustomStyle.textSemiBold12.copyWith(
                  color: widget.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
