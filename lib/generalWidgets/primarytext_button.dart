import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/res/typography.dart';

class PrimaryTextButton extends StatefulWidget {
  const PrimaryTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.fontSize,
      required this.textColor});
  final Function() onPressed;
  final String title;
  final double fontSize;
  final Color textColor;

  @override
  State<PrimaryTextButton> createState() => _PrimaryTextButtonState();
}

class _PrimaryTextButtonState extends State<PrimaryTextButton>
    with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         
        widget.onPressed();
      },
      child: Text(widget.title,
          style: CustomStyle.textMedium14.copyWith(
            color: widget.textColor,
            fontSize: widget.fontSize.sp,
          )),
    );
  }
}
