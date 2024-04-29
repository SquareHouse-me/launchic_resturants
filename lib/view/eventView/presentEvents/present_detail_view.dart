import 'dart:ui';

 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottied;
import 'package:restaurant/data/status.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/images_urls.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/utils/utils.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentDetailView extends StatefulWidget {
  const PresentDetailView({
    super.key,
  });

  @override
  State<PresentDetailView> createState() => _PresentDetailViewState();
}

class _PresentDetailViewState extends State<PresentDetailView> {
 String? id;
  @override
  void initState() {
    super.initState();
    id=Get.arguments[0];
   event.getPresentCurrentReservation(id: id!);
  }

  final event = Get.find<HomeController>();
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
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() => event.getPresentAppStatusDetail.value == AppStatus.LOADING
            ? Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0).copyWith(top: 90.h),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: lottied.Lottie.asset(
                      'assets/images/loading.json',
                      width: 60.w,
                      height: 60.h,
                    ),
                  ),
                ),
              )
            : event.getPresentAppStatusDetail.value == AppStatus.COMPLETED
                ? SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Obx(() => event.kGooglePlex.value == null
                                ?  Container(
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: AssetImage(
                        AppImageUrl.mapViewLogo
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: 170.h,
                      child: Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                                : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      height: 230.0.h,
                                      child: GoogleMap(
                                        indoorViewEnabled: false,
                                        liteModeEnabled: false,
                                        initialCameraPosition:
                                            event.kGooglePlex.value!,
                                        markers: Set<Marker>.of(
                                            event.listOfMarker.value),
                                      ),
                                    )) ,
                              SizedBox(
                                height: 9.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        event.getPresentDetailReservationModel.value
                                            .restaurant!.name
                                            .toString(),
                                        style: CustomStyle.textBold30.copyWith(
                                          color: AppColors.light100BlackColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        event.getPresentDetailReservationModel.value
                                            .restaurant!.location
                                            .toString(),
                                        style: CustomStyle.textRegular15.copyWith(
                                          color: AppColors.light100BlackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     final url = 'tel:' +
                                  //         event.getPresentDetailReservationModel.value
                                  //             .restaurant!.phone
                                  //             .toString();
                                  //     launchUrl(
                                  //       Uri.parse(url),
                                  //       mode: LaunchMode.externalApplication,
                                  //     );
                                  //   },
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(8.0)
                                  //         .copyWith(right: 0.w, bottom: 23.h),
                                  //     child: Icon(
                                  //       CupertinoIcons.phone,
                                  //       color: Colors.blueAccent,
                                  //       size: 34.sp,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              )
                            ],
                          ),
                          ReusableRow(
                            title: 'User Name  :',
                            value: event.getPresentDetailReservationModel.value.  customer
                                .toString(),
                          ),
                          ReusableRow(
                            title: 'Booking Date  :',
                            value: event.getPresentDetailReservationModel.value.bookingDate
                                .toString(),
                          ),
                          ReusableRow(
                            title: 'Order Time  :',
                            value: event.getPresentDetailReservationModel.value.bookingTime
                                .toString(),
                          ),
                          ReusableRow(
                            title: 'Party Size  :',
                            value: event.getPresentDetailReservationModel.value.partySize
                                .toString(),
                          ),
                          // ReusableRow(
                          //   title: 'Phone  :',
                          //   value: event
                          //       .reservationModel.value.data!.restaurant.phone
                          //       .toString(),
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.all(4.0).copyWith(top: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Status  :',
                                  style: CustomStyle.textSemiBold20
                                      .copyWith(fontSize: 15.sp),
                                ),
                                InkWell(
                                  onTap: event.getPresentDetailReservationModel.value
                                              .status
                                              .toString() ==
                                          'approved'
                                      ? () {
                                          event.showCancelDialog(
                                              isDetailView: true,
                                              reservationDetailList: event
                                                  .getPresentDetailReservationModel.value);
                                        }
                                      : event.getPresentDetailReservationModel.value
                                                  .status
                                                  .toString() ==
                                              'pending'
                                          ? () {
                                              event.showCancelConfirmDialog(
                                                  isDetailView: true,
                                                   
                                                  reservationDetailListModel:
                                                      event
                                                          .getPresentDetailReservationModel
                                                          .value);
                                            }
                                          : () {
                                              
                                              
                                            },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: getContainerOrderStatusColor(event
                                            .getPresentDetailReservationModel.value.status
                                            .toString())),
                                    child: Text(
                                      event.getPresentDetailReservationModel.value.status ??
                                          'empty',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: getOrderStatusColor(event
                                            .getPresentDetailReservationModel.value.status
                                            .toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                            child: lottied.Lottie.asset(
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
                                  event.getPresentErrorDetailText.value.toString(),
                                  style: CustomStyle.textSemiBold12.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {},
                                icon: Icon(
                                  Icons.refresh_sharp,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }

  Color getOrderStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
case 'completed':
         return Colors.green;
      default:
        return Colors.orange;
    }
  }

  Color getContainerOrderStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green.withOpacity(0.2);

      case 'cancelled':
        return Colors.red.shade400.withOpacity(0.2);
        case 'completed':
         return Colors.green.withOpacity(0.2);
      default:
        return Colors.orange.shade400.withOpacity(0.2);
    }
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0).copyWith(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: CustomStyle.textSemiBold20.copyWith(fontSize: 15.sp),
          ),
          Text(
            value,
            style: CustomStyle.textRegular16.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
