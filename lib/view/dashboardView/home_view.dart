import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant/animation/scaletransition_animation.dart';
import 'package:restaurant/data/status.dart';

import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/images_urls.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/view/dashboardView/widgets/date_formatted.dart';
import 'package:restaurant/viewModel/controllers/auth_controller.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';
import 'package:restaurant/viewModel/services/notification_services.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final HomeController reservationController = Get.find<HomeController>();
  final AuthController auth = Get.find<AuthController>();

  NotificationServices services = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reservationController.getAllReservationByBookingDate();
    reservationController.getAllReservation();
     checkAndRefreshToken();

  }

  Future<void> checkAndRefreshToken() async {
    String? deviceToken = await services.getDeviceToken();

    // Retrieve the saved token and its timestamp
    var box = Hive.box('userBox');
    String? savedDeviceToken = box.get('DeviceToken');
    int? savedTokenTimestamp = box.get('TokenTimestamp');

    log('$savedDeviceToken savedDeviceToken');
    log('$deviceToken deviceToken');

    // Define a token expiration period, for example, 24 hours
    const tokenExpirationPeriod = Duration(hours: 24);
    bool isTokenExpired = savedTokenTimestamp == null ||
        DateTime.now().millisecondsSinceEpoch - savedTokenTimestamp >
            tokenExpirationPeriod.inMilliseconds;

    if (deviceToken == savedDeviceToken && !isTokenExpired) {
      log('Token is not expired. No need to refresh.');

      auth.saveDeviceTokenMethod(
          saveToken: savedDeviceToken.toString());
    } else {
      log('Token is expired or different. Refreshing...');
      String newToken = await services
          .isTokenRefresh(); // This method needs to be synchronous or handle the refresh differently
      log('$newToken dd');
      auth.saveDeviceTokenMethod(saveToken: newToken);
    }

    // _locationService.initLocationService();
  }

  String photoUrl = '';
  @override
  Widget build(BuildContext context) {
    photoUrl = Hive.box('userBox').get('restaurantLogo') ?? '';

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: ScalesTransitionAnimation(
                      child: Container(
                        width: 140.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightGrey12Color,
                            image: photoUrl.isEmpty
                                ? DecorationImage(
                                    image: AssetImage(
                                        'assets/images/placeholder.png'),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      photoUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),
                  Text(
                    'todayText'.tr,
                    style: CustomStyle.textRegular12.copyWith(
                      fontSize: 8.0.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'reservationText'.tr,
                    style: CustomStyle.textRegular12.copyWith(
                      color: Colors.black,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Obx(() => RichText(
                        text: TextSpan(
                          style: CustomStyle.textRegular12.copyWith(
                            fontSize: 30.0.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldenColor,
                          ),
                          children: [
                            TextSpan(
                                text: reservationController
                                        .tableData.value.length
                                        .toString() +
                                    " "),
                            TextSpan(
                              text: 'totalReservation'.tr,
                              style: CustomStyle.textRegular12.copyWith(
                                color: Colors.black,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 39.h,
                  ),
                  Text(
                    'incomingText'.tr,
                    style: CustomStyle.textRegular12.copyWith(
                      fontSize: 8.0.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'reservationText'.tr,
                    style: CustomStyle.textRegular12.copyWith(
                      color: Colors.black,
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  InkWell(
                    onTap: () {
                      reservationController.selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => SizedBox(
                              child: DateFormattedWidget(
                                  currentDate:
                                      reservationController.selectedDate.value),
                            )),
                        SizedBox(
                          width: 50.w,
                        ),
                        SvgPicture.asset(AppIcons.arrowDown),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => reservationController.eventAppStatus.value ==
                    AppStatus.LOADING
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
                : reservationController.eventAppStatus.value ==
                        AppStatus.COMPLETED
                    ? reservationController.tableData.value.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Lottie.asset(
                                      'assets/images/not_found.json',
                                      width: 100.w,
                                      height: 100.h,
                                    ),
                                  ),
                                  Text(
                                    'noReservationsText'.tr,
                                    style: CustomStyle.textBold24
                                        .copyWith(fontSize: 20.sp),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 20.h),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Size')),
                                DataColumn(label: Text('Time')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('View')),
                              ],
                              rows: reservationController.tableData.value
                                  .map((rowData) {
                                String statusText = reservationController
                                    .getStatusName(rowData.status.toString());
                                log(statusText.toLowerCase().toString());
                                Color textColor = reservationController
                                    .getStatusColor(statusText.toLowerCase());

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
                                      onTap: () {
                                        if (statusText
                                                .toLowerCase()
                                                .toString() ==
                                            'approved') {
                                          reservationController
                                              .showCancelDialog(
                                                  isDetailView: false,
                                                  rowDataValue: rowData);
                                        } else {
                                          reservationController
                                              .showCancelConfirmDialog(
                                                  isDetailView: false,
                                                  rowDataValue: rowData);
                                        }
                                      },
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
                                        onTap: () {
                                          Get.toNamed(
                                              RouteName.upComingDetailView,
                                              arguments: [
                                                rowData.id.toString()
                                              ]);
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
                          )
                    : reservationController.eventAppStatus.value ==
                        AppStatus.UNAUTHORIZED? Center(child: SvgPicture.asset(AppIcons.unAuthorized,width: 200.w,height: 240.h,),): Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0).copyWith(top: 200.h),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Lottie.asset(
                                  'assets/images/error_lottie.json',
                                  width: 300.w,
                                  height: 100.h,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      reservationController.errorEventText.value
                                          .toString(),
                                      style: CustomStyle.textSemiBold12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackColor,
                                        fontSize: 14.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await reservationController
                                          .getAllReservationByBookingDate();
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
                      )),
          ],
        ),
      ),
    );
  }
}
