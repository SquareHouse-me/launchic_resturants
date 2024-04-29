import 'dart:developer';
 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant/data/status.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';
 
class PastCompletedReservation extends StatefulWidget {
  @override
  State<PastCompletedReservation> createState() =>
      _PastCompletedReservationState();
}

class _PastCompletedReservationState extends State<PastCompletedReservation> {
  final eventController = Get.find<HomeController>();
 final auth = Get.find<AuthController>();
   
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _refresh();
  }
  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eventController.getAllPastReservation();
      // eventController.pastEventAppStatus.update((status) {
      //   // notify the observer that the status has changed
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.blackColor,
      backgroundColor: Colors.white,
      onRefresh: _refresh,
       
      child: Obx(
        () {
          return eventController.pastReservationEventAppStatus.value == AppStatus.LOADING
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0).copyWith(top: 30.h),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset(
                        'assets/images/loading.json',
                        width: 200.w,
                        height: 60.h,
                      ),
                    ),
                  ),
                )
              : eventController.pastReservationEventAppStatus.value == AppStatus.COMPLETED
                  ? eventController.pastCompletedReservationList.value.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 170.h),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Lottie.asset(
                                    'assets/images/not_found.json',
                                    width: 200.w,
                                    height: 200.h,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0)
                                      .copyWith(top: 0),
                                  child: Text(
                                    'noPastReservation'.tr,
                                    style: CustomStyle.textBold24.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 34.h),
                          child: AnimationLimiter(
                            child: DataTable(
                              columnSpacing: 37,
                              columns: [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Size')),
                                DataColumn(label: Text('Time')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('View')),
                              ],
                              rows: eventController
                                  .pastCompletedReservationList.value
                                  .map((rowData) {
                                String statusText =
                                    eventController.getStatusName(rowData.status!
                                        .toLowerCase()
                                        .toString());
                                log(statusText.toString());
                                Color textColor =
                                    eventController.getStatusColor(
                                        statusText.toLowerCase().toString());

                                return DataRow(
                                  cells: [
                                    DataCell(Text(
                                      '${rowData.customer.toString()}',
                                      style: CustomStyle.textSemiBold12
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                    )),
                                    DataCell(Text(
                                      '${rowData.partySize}',
                                      style: CustomStyle.textSemiBold12
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                    )),
                                    DataCell(Text(
                                      '${rowData.bookingTime.toString()}',
                                      style: CustomStyle.textSemiBold12
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                    )),
                                    DataCell(
                                      Text(
                                        '$statusText',
                                        style: CustomStyle.textSemiBold12
                                            .copyWith(
                                                color: textColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                      ),
                                    ),
                                    DataCell(
                                      InkWell(
                                        onTap: () async {
                                          Get.toNamed(
                                              RouteName.pastUpComingDetailView,
                                              arguments: [rowData]);
                                        },
                                        child: SvgPicture.asset(
                                          AppIcons.viewIcon,
                                          color: AppColors.goldenColor,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        )
                  :     Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0).copyWith(top: 200.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Lottie.asset(
                                'assets/images/error_lottie.json',
                                width: 300.w,
                                height: 150.h,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    eventController.pastErrorReservationEventText.value
                                        .toString(),
                                    style: CustomStyle.textSemiBold12.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await eventController
                                        .getAllPastReservation();
                                  },
                                  icon: Icon(
                                    Icons.refresh_sharp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
