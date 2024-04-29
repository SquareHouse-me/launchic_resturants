import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/res/colors.dart';
 
class CountryCodeWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String countryCode;
  final String countryEmoji;
  final VoidCallback? onTap;
  final Color hintColor;

  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final Color enabledBorder;
  final Color focusedBorder;
  final Color iconData;
  final Color styleColor;
  final Color titleColor;
  final Color defaultTitleColor;
  const CountryCodeWidget({
    Key? key,
    required this.hintColor,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.onTap,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    required this.countryCode,
    required this.countryEmoji,
    required this.enabledBorder,
    required this.focusedBorder,
    required this.styleColor,
    required this.iconData,
    required this.titleColor,
    required this.defaultTitleColor,
  }) : super(key: key);

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(onTapOutside: (p0) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
        textInputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8), // Adjust the limit as needed
        ],
        styleColor: widget.styleColor,
        enabledBorder: widget.enabledBorder,
        focusedBorder: widget.focusedBorder,
        textInputAction: TextInputAction.done,
        controller: widget.controller,
        hintText: widget.hintText,
        obscureText: false,
        hintColor: widget.hintColor,
        keyboardType: TextInputType.phone,
        prefixIcon: InkWell(
          onTap: widget.onTap,
          child: SizedBox(
            width: 100.w,
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 15.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      widget.countryEmoji,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "+${widget.countryCode}",
                      style: TextStyle(
                        color: widget.titleColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        validator: widget.validator);
  }
}
