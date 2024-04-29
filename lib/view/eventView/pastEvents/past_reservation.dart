// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/view/eventView/pastEvents/Widgets/past_completed_reservation.dart';
import 'package:restaurant/view/eventView/pastEvents/Widgets/past_pending_reservation.dart';
import 'package:restaurant/view/eventView/pastEvents/Widgets/past_upcoming_reservation.dart';
import 'package:restaurant/view/eventView/widgets/cancelled_pastreservation.dart';

import '../presentEvents/Widgets/pending_reservation_view.dart';

class PastReservationScreen extends StatelessWidget {
  
  PastReservationScreen({
    Key? key,
     
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          ),
         title: Text('Reservations',
            style: CustomStyle.textBold36.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.sp
            )),
            centerTitle: true,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            padding: EdgeInsets.zero,
             
              isScrollable: true,labelStyle:  
                                               CustomStyle.textSemiBold12
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blackColor,
                                                fontSize: 13.sp,
                                              ),
              tabAlignment: TabAlignment.center,
              labelColor: AppColors.blackColor,
              indicatorColor: AppColors.blackColor,
              unselectedLabelColor: AppColors.light60GreyColor,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Cancelled'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(children: [
          PastPendingReservation(),
          PastUpComingReservation(),
          CancelledPastReservation(),
          PastCompletedReservation()
        ]),
      ),
    );
  }
}
