import 'dart:developer';
 
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lotties;
import 'package:restaurant/data/model/reservation_detail_model.dart';
import 'package:restaurant/data/status.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';

class UpComingDetailView extends StatefulWidget {
  const UpComingDetailView({Key? key}) : super(key: key);

  @override
  _UpComingDetailViewState createState() => _UpComingDetailViewState();
}

class _UpComingDetailViewState extends State<UpComingDetailView> {
  final detailHomeC = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    detailHomeC.getCurrentReservation(id: id.toString());

    detailHomeC.dataRepo().then((value) => (log('data')));
  }

  String? id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(title: Text(
                                                'Details',
                                                style: CustomStyle.textSemiBold12
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.blackColor,
                                                  fontSize: 20.sp,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                              centerTitle: true,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          ),
          
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(
          () => detailHomeC.upcomingReservationAppStatus.value == AppStatus.LOADING
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0).copyWith(top: 30.h),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: lotties.Lottie.asset(
                        'assets/images/loading.json',
                        width: 200.w,
                        height: 60.h,
                      ),
                    ),
                  ),
                )
              : detailHomeC.upcomingReservationAppStatus.value == AppStatus.COMPLETED
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    detailHomeC.upcomingReservationDetailModel.value
                                        .restaurant!.banner
                                        .toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 170.h,
                              child: Stack(
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            SectionTitle(title: 'Reservation Details'),
                            SizedBox(height: 16.h),
                            DetailRow(
                              title: 'Customer Name:',
                              value: detailHomeC
                                  .upcomingReservationDetailModel.value.customer
                                  .toString(),
                            ),
                            DetailRow(
                              title: 'Booking Date:',
                              value: detailHomeC
                                  .upcomingReservationDetailModel.value.bookingDate
                                  .toString(),
                            ),
                            DetailRow(
                              title: 'Booking Time:',
                              value: detailHomeC
                                  .upcomingReservationDetailModel.value.bookingTime
                                  .toString(),
                            ),
                            DetailRow(
                              title: 'Month:',
                              value: getMonth().format(DateTime.parse(detailHomeC
                                  .upcomingReservationDetailModel.value.bookingDate!)),
                            ),
                            DetailRow(
                              title: 'Day:',
                              value: DateFormat(" d").format(DateTime.parse(
                                  detailHomeC.upcomingReservationDetailModel.value
                                      .bookingDate!)),
                            ),
                            DetailRow(
                              title: 'Party Size:',
                              value: detailHomeC
                                  .upcomingReservationDetailModel.value.partySize
                                  .toString(),
                            ),
                            SizedBox(height: 6.h),
                            SectionTitle(title: 'Order Status'),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Status:',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: detailHomeC.upcomingReservationDetailModel.value
                                              .status
                                              .toString() ==
                                          'approved'
                                      ? () {
                                          detailHomeC.showCancelDialog(
                                              isDetailView: true,
                                              reservationDetailList: detailHomeC
                                                  .upcomingReservationDetailModel.value);
                                        }
                                      :  () {
                                              detailHomeC.showCancelConfirmDialog(
                                                  isDetailView: true,
                                                  
                                                  
                                                  reservationDetailListModel:
                                                      detailHomeC
                                                          .upcomingReservationDetailModel
                                                          .value);
                                            }
                                           ,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: detailHomeC
                                            .getContainerOrderStatusColor(
                                                detailHomeC
                                                    .upcomingReservationDetailModel
                                                    .value
                                                    .status
                                                    .toString())),
                                    child: Text(
                                      detailHomeC.upcomingReservationDetailModel.value
                                              .status ??
                                          'empty',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: detailHomeC.getStatusColor(
                                            detailHomeC.upcomingReservationDetailModel
                                                .value.status
                                                .toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Obx(() => detailHomeC.kGooglePlex.value == null
                                ?  SizedBox()
                                : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      height: 230.0.h,
                                      child: GoogleMap(
                                        indoorViewEnabled: false,
                                        liteModeEnabled: false,
                                        initialCameraPosition:
                                            detailHomeC.kGooglePlex.value!,
                                        markers: Set<Marker>.of(
                                            detailHomeC.listOfMarker.value),
                                      ),
                                    )),
                            SizedBox(
                              height: 12.h,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0).copyWith(top: 200.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: lotties.Lottie.asset(
                                'assets/images/error_lottie.json',
                                width: 300.w,
                                height: 100.h,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  detailHomeC.errorUpcomingReservationDetailText.value.toString(),
                                  style: CustomStyle.textSemiBold12.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await detailHomeC.getCurrentReservation(
                                        id: id.toString());
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
                    ),
        ),
      ),
    );
  }

  DateFormat getMonth() => DateFormat("MMMM");

  void changeStatus(int rowIndex, OrderStatus orderStatus) {
    log("newStatus :" + orderStatus.name.toString());
    detailHomeC.tableData.value[rowIndex].status = orderStatus.name;
    log("tableData :" +
        detailHomeC.tableData.value[rowIndex].status.toString());
    detailHomeC.tableData.refresh();
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
