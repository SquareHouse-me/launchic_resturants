 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color? styleColor;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int? maxLength;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final Function(PointerDownEvent)? onTapOutside;
  final Color enabledBorder, focusedBorder;
  final String? Function(String?)? onChanged;
  final Color? hintColor;
  final List<TextInputFormatter>? textInputFormatter;
  const PrimaryTextField(
      {super.key,
      this.textInputFormatter,
      this.styleColor,
   required  this.onTapOutside,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.hintColor,
      this.maxLength,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged,
      required this.textInputAction,
      required this.enabledBorder,
      required this.focusedBorder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLength: maxLength,
      onTap: onTap,
      inputFormatters: textInputFormatter,
      textInputAction: textInputAction,
      onChanged: onChanged,
      style: TextStyle(color: styleColor ?? AppColors.whiteColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        helperText: '',
        
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: enabledBorder),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: focusedBorder),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        fillColor: Colors.transparent,
        filled: false,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 10.sp)
            .copyWith(color: hintColor ?? AppColors.whiteColor, fontWeight: FontWeight.w400),
        errorText: errorMsg,
      ),
      onTapOutside: onTapOutside,
    );
  }
}
