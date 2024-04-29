import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';

class DateFormattedWidget extends StatelessWidget {
  final DateTime currentDate;
  const DateFormattedWidget({
    Key? key,
    required this.currentDate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get the current date

    // Format the date dynamically
    String formattedDate = formatDynamicDate(currentDate);

    // Display the formatted date
    return Text(
      formattedDate,
      style: CustomStyle.textRegular12.copyWith(
        color: AppColors.goldenColor,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String formatDynamicDate(DateTime date) {
    // Get yesterday's date
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    // Check if the date is today or yesterday
    bool isToday = date.day == DateTime.now().day;
    bool isYesterday = date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;

    if (isToday) {
      return DateFormat("'Today,' d MMMM").format(date);
    } else if (isYesterday) {
      return DateFormat("'Yesterday,' d MMMM").format(date);
    } else {
      return DateFormat('d, MMMM').format(date);
    }
  }
}
