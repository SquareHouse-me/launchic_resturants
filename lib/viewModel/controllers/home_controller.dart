import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:restaurant/data/model/past_reservation_model.dart';
import 'package:restaurant/data/model/reservation_detail_model.dart' as statuss;
import 'package:restaurant/data/model/reservation_detail_model.dart';

import 'package:restaurant/data/model/reservation_model.dart';
import 'package:restaurant/data/repositories/home_repo.dart';
import 'package:restaurant/data/status.dart';
import 'package:restaurant/generalWidgets/thankyou_dialog.dart';
import 'package:restaurant/generalWidgets/upgrade_dialog.dart';
import 'package:restaurant/res/app_urls.dart';

import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/utils/utils.dart';
import 'package:restaurant/viewModel/services/auth_services.dart';
import 'package:restaurant/viewModel/services/notification_services.dart';

import '../../data/model/contact_us.dart';

class HomeController extends GetxController { 

  RxString unAuthorized=''.obs;
  Rx<AppStatus> contactUsAppStatus = AppStatus.LOADING.obs;
  void setContactUsAppStatus(AppStatus _value) =>
      contactUsAppStatus.value = _value;
  RxString contactUsError = ''.obs;
  void setContactUsError(String _errorValue) =>
      contactUsError.value = _errorValue;

  Rx<ContactData?> _contactUsModel = ContactData().obs;
  ContactData? get contactUsModel => _contactUsModel.value;
  void setContactUsModel(ContactData _value) => _contactUsModel.value = _value;
////////////////////////////////////////////////////////////////////
  Rx<CameraPosition?> kGooglePlex = Rx(null);

  Rx<List<Marker>> listOfMarker = Rx<List<Marker>>([]);

  Rx<List<MyReservationList>> tableData = Rx<List<MyReservationList>>([]);
  final _fireStore = FirebaseFirestore.instance;
  Rx<List<MyReservationList>> myReservationModelList =
      Rx<List<MyReservationList>>([]);
  Rx<DateTime> selectedDate = Rx(DateTime.now());
  RxBool isLoading = false.obs;
  RxString errorText = ''.obs;
  final homeRepo = HomeRepository();
  void setIsLoading(bool _value) => isLoading.value = _value;
  void setError(String _errorValue) => errorText.value = _errorValue;
  AuthServices _authServices = AuthServices();
  RxBool isBookLoading = false.obs;

  RxString errorEventText = ''.obs;

  Rx<AppStatus> eventAppStatus = AppStatus.LOADING.obs;

// ....................................................................///

// app state define for upcoming Present Events reservations
  Rx<AppStatus> reservationEventAppStatus = AppStatus.LOADING.obs;
  RxString errorReservationEventText = ''.obs;

  Rx<AppStatus> cancelledReservationAppStatus = AppStatus.LOADING.obs;
  RxString errorCancelledPastEventText = ''.obs;

// define all Upcoming list for  reservations
  Rx<List<MyReservationList>> pendingReservationList =
      Rx<List<MyReservationList>>([]);
  Rx<List<MyReservationList>> upComingReservationList =
      Rx<List<MyReservationList>>([]);
  Rx<List<MyReservationList>> completedReservationList =
      Rx<List<MyReservationList>>([]);

// define all past list for  reservations
  Rx<List<PastList>> pastPendingReservationList = Rx<List<PastList>>([]);
  Rx<List<PastList>> pastUpComingReservationList = Rx<List<PastList>>([]);
  Rx<List<PastList>> pastCompletedReservationList = Rx<List<PastList>>([]);

// set for cancelledReservationList event also
  Rx<List<PastList>> cancelledReservationList = Rx<List<PastList>>([]);

// app state define for  Past Events reservations
  Rx<AppStatus> pastReservationEventAppStatus = AppStatus.LOADING.obs;
  RxString pastErrorReservationEventText = ''.obs;

  // set reservation error text and app state for present events list
  void setReservationEventError(String _errorValue) =>
      errorReservationEventText.value = _errorValue;
  void setReservationAppStatus(AppStatus _value) =>
      reservationEventAppStatus.value = _value;

  // set reservation error text and app state for past events list
  void setPastReservationEventError(String _errorValue) =>
      pastErrorReservationEventText.value = _errorValue;
  void setPastReservationEventAppStatus(AppStatus _value) =>
      pastReservationEventAppStatus.value = _value;

  //for cancelled
  void setPastCancelledEventAppStatus(AppStatus _value) =>
      cancelledReservationAppStatus.value = _value;

// set all present events list
  void setPendingEventList(List<MyReservationList> _value) =>
      pendingReservationList.value = _value;
  void setUpComingEventList(List<MyReservationList> _value) =>
      upComingReservationList.value = _value;
  void setCompletedEventList(List<MyReservationList> _value) =>
      completedReservationList.value = _value;
// set all Past events list
  void setPastPendingEventList(List<PastList> _value) =>
      pastPendingReservationList.value = _value;
  void setPastUpComingEventList(List<PastList> _value) =>
      pastUpComingReservationList.value = _value;
  void setPastCompletedEventList(List<PastList> _value) =>
      pastCompletedReservationList.value = _value;

// set for CancelledEventList also
  void setCancelledEventList(List<PastList> _value) =>
      cancelledReservationList.value = _value;

//.............................................................................//

// Present Reservation tabs
  Rx<AppStatus> getPresentAppStatusDetail = AppStatus.LOADING.obs;
  RxString getPresentErrorDetailText = ''.obs;
  Rx<ReservationDetailList> getPresentDetailReservationModel =
      ReservationDetailList().obs;
  void setPresentDetailsModel(ReservationDetailList _value) =>
      getPresentDetailReservationModel.value = _value;
  void setPresentStatusDetailModel(AppStatus _value) =>
      getPresentAppStatusDetail.value = _value;
  void setGetPresentErrorDetail(String _errorValue) =>
      getPresentErrorDetailText.value = _errorValue;

///////////////////////////////////////////////////////////////

  /// upcoming detail view
  Rx<AppStatus> upcomingReservationAppStatus = AppStatus.LOADING.obs;
  RxString errorUpcomingReservationDetailText = ''.obs;
  Rx<ReservationDetailList> upcomingReservationDetailModel =
      ReservationDetailList().obs;
  void setUpcomingDetailsModel(ReservationDetailList _value) =>
      upcomingReservationDetailModel.value = _value;
  void setUpcomingAppStatusDetail(AppStatus _value) =>
      upcomingReservationAppStatus.value = _value;
  void setUpcomingErrorDetail(String _errorValue) =>
      errorUpcomingReservationDetailText.value = _errorValue;

//////////////////////////////
  void setEventAppStatus(AppStatus _value) => eventAppStatus.value = _value;

  void setEventError(String _errorValue) => errorEventText.value = _errorValue;

  void setBookLoading(bool value) => isBookLoading.value = value;
  void setPastCancelledEventError(String _errorValue) =>
      errorCancelledPastEventText.value = _errorValue;

  void setEventList(List<MyReservationList> _value) =>
      myReservationModelList.value = _value;
  NotificationServices services = NotificationServices();
  @override
  void onInit() {
    super.onInit();
    services.requestNotificationPermission();
    services.setupInteractMessage(Get.context!);
    services.firebaseInit(Get.context!);

    log(
      DateFormat('yyyy-MM-dd')
          .format(selectedDate.value)
          .toLowerCase()
          .toString(),
    );
  }

  @override
  void onReady() {
    super.onReady();
    log('onReady');
    checkVersion();
  }

  RxString urls = ''.obs;
  Future<void> checkVersion() async {
    // Simulate an API response

    await homeRepo.forceFullyUpdate().then(
      (value) async {
        log(value['data'].toString());
        // Extract version from API response
        // String apiVersion = responseJson['data'];
        String apiVersion = value['data']['app_version'].toString();
        urls.value = value['data']['update_url'].toString();
        // Get current app version
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String appVersion = packageInfo.version;
        log(appVersion.toString());
        // Compare versions
        if (isNewerVersion(apiVersion, appVersion)) {
          // Show update dialog
          UpgradeDialog.showLocationDialog(Get.context!, urls.value);
          ;
        }
      },
    ).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  bool isNewerVersion(String apiVersion, String appVersion) {
    // Simple version comparison: This might need to be more sophisticated
    // depending on your versioning scheme
    return apiVersion.compareTo(appVersion) > 0;
  }

  void changeStatus(int rowIndex, statuss.OrderStatus orderStatus) {
    log("newStatus :" + orderStatus.name.toString());
    tableData.value[rowIndex].status = orderStatus.name;
    log("tableData :" + tableData.value[rowIndex].status.toString());
    tableData.refresh();
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;
      // log(DateFormat('d MMMM').format(selectedDate.value));
      inputDate(DateFormat('yyyy-MM-dd').format(selectedDate.value));
    }
  }

  inputDate(String date) {
    // log(date.toLowerCase().toString() + " input date");
    tableData.value = myReservationModelList.value.where((element) {
      String margieDate = DateFormat('yyyy-MM-dd').format(
        DateTime.parse(
          element.bookingDate.toString(),
        ),
      );
      final value = margieDate == date.toLowerCase().toString();
      // log(value.toString());
      return value;
    }).toList();

    log(tableData.value.length.toString());
    tableData.refresh();
  }

  String getStatusName(String orderStatus) {
    switch (orderStatus) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      case 'completed':
        return 'Completed';

      default:
        return 'Pending'; // Default color if status is not recognized
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;

      case 'cancelled':
        return Colors.red.withOpacity(0.5);
      case 'completed':
        return Colors.green;
      default:
        return Colors.orange; // Default color if status is not recognized
    }
  }

  Future<void> showStatusDialog(MyReservationList rowData) async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                top: 190.h,
                left: 50.w,
                child: Text(
                  'alertText'.tr,
                  style: CustomStyle.textRegular12.copyWith(
                    color: Colors.white,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 280.w,
                top: 180.h,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 23.sp,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              CupertinoAlertDialog(
                content: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: RichText(
                        textHeightBehavior: TextHeightBehavior(),
                        text: TextSpan(
                          style: CustomStyle.textRegular12.copyWith(
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                          children: [
                            TextSpan(text: 'guestReservationText'.tr + " "),
                            TextSpan(
                              text: rowData.bookingDate.toString(),
                              style: CustomStyle.textRegular12.copyWith(
                                color: Colors.black,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " - partySize : ${rowData.partySize.toString()} ",
                              style: CustomStyle.textRegular12.copyWith(
                                color: Colors.black,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'peopleText'.tr,
                              style: CustomStyle.textRegular12.copyWith(
                                color: Colors.black,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      'cancelText'.tr,
                      style: CustomStyle.textRegular12.copyWith(
                        color: Colors.black,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      'confirmedText'.tr,
                      style: CustomStyle.textRegular12.copyWith(
                        color: Colors.black,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      // Update the status in the GetX controller
                      // changeStatus(
                      //   tableData.value.indexOf(rowData),
                      //   OrderStatus.confirmed,
                      // );
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showCancelConfirmDialog(
      {ReservationDetailList? reservationDetailListModel,
      MyReservationList? rowDataValue,
      required bool isDetailView}) async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Padding(
            padding: EdgeInsets.only(top: 0.h),
            child: RichText(
              textHeightBehavior: TextHeightBehavior(),
              text: TextSpan(
                style: CustomStyle.textRegular12.copyWith(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                children: [
                  TextSpan(text: 'This order status is Pending\n'),
                  TextSpan(
                    text: 'Would you like to cancel or confirm this reservation?'  ,
                    style: CustomStyle.textRegular12.copyWith(
                      color: Colors.black,
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TextSpan(
                  //   text: "reservation? ",
                  //   style: CustomStyle.textRegular12.copyWith(
                  //     color: Colors.black,
                  //     fontSize: 15.0.sp,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'Cancel'.tr,
                style: CustomStyle.textRegular12.copyWith(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                if (isDetailView) {
                  Get.back();
                  getCancelCurrentReservation(
                          id: reservationDetailListModel!.id.toString())
                      .then((value) async {
                    Get.back();

                    getAllReservationByBookingDate();
                    getAllReservation();
                  });
                } else {
                  await getCancelCurrentReservation(
                          id: rowDataValue!.id.toString())
                      .then((value) async {
                    Get.back();
                    await getAllReservationByBookingDate();
                    await getAllReservation();
                  });
                }

                //  changeStatus(
                //   detailHomeC.tableData.value.indexOf(rowData),
                //   OrderStatus.cancelled,
                // );
              },
            ),
            CupertinoDialogAction(
              child: Text(
                'Confirm ',
                style: CustomStyle.textRegular12.copyWith(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                if (isDetailView) {
                  Get.back();
                  getApprovedCurrentReservation(
                          id: reservationDetailListModel!.id.toString())
                      .then((value) async {
                    Get.back();

                    await getAllReservationByBookingDate();
                    await getAllReservation();
                  });
                } else {
                  Get.back();
                  getApprovedCurrentReservation(id: rowDataValue!.id.toString())
                      .then((value) async {
                    await getAllReservationByBookingDate();
                    await getAllReservation();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showCancelDialog(
      {ReservationDetailList? reservationDetailList,
      MyReservationList? rowDataValue,
      required bool isDetailView}) async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Padding(
            padding: EdgeInsets.only(top: 0.h),
            child: RichText(
              textHeightBehavior: TextHeightBehavior(),
              text: TextSpan(
                style: CustomStyle.textRegular12.copyWith(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                children: [
                  TextSpan(
                    text: 'Do u want to cancel this' + " ",
                    style: CustomStyle.textRegular12.copyWith(
                      color: Colors.black,
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "reservation? ",
                    style: CustomStyle.textRegular12.copyWith(
                      color: Colors.black,
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'Yes'.tr,
                style: CustomStyle.textRegular12.copyWith(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                if (isDetailView) {
                  Get.back();
                  log(reservationDetailList!.id.toString() +
                      " isDetailView: $isDetailView");

                  getCancelCurrentReservation(
                          id: reservationDetailList.id.toString())
                      .then((value) async {
                    Get.back();
                    getAllReservationByBookingDate();
                    getAllReservation();
                  });
                } else {
                  log(rowDataValue!.id.toString() +
                      " isDetailView: $isDetailView");
                  Get.back();
                  await getCancelCurrentReservation(
                          id: rowDataValue.id.toString())
                      .then((value) async {
                    getAllReservationByBookingDate();
                    getAllReservation();
                  });
                }
              },
            ),
            CupertinoDialogAction(
              child: Text(
                'No',
                style: CustomStyle.textRegular12.copyWith(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Color getContainerOrderStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green.withOpacity(0.2);

      case 'approved':
        return Colors.green.withOpacity(0.2);

      case 'cancelled':
        return Colors.red.shade400.withOpacity(0.2);
      default:
        return Colors.orange.shade400.withOpacity(0.2);
    }
  }
  
  Future<void> getAllReservationByBookingDate() async {
    try {
      setEventAppStatus(AppStatus.LOADING);

      await homeRepo.getAllUpComingReservation().then((value) {
        if (value['statusCode'].toString() == '200') {
          ReservationModel res = ReservationModel.fromJson(value);
          log("get All Reservation success " + value['statusCode'].toString());
          setEventList(res.data!);
          log(res.data!.length.toString());
          //for getting all data current list
          tableData.value = res.data!
              .where(
                (element) =>
                    DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                        element.bookingDate.toString(),
                      ),
                    ) ==
                    DateFormat('yyyy-MM-dd')
                        .format(selectedDate.value)
                        .toLowerCase()
                        .toString(),
              )
              .toList();
          setEventAppStatus(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          log('anUth');
          setEventError(value['data']['message'].toString());
          setEventAppStatus(AppStatus.ERROR);
        } else {
          // log(value['message'].toString());
          
             setEventError(value['message'].toString());
          setEventAppStatus(AppStatus.ERROR);
           
         
          
        }
      }).onError((error, stackTrace) {
        setEventError(error.toString());
        setEventAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setEventError('something went wrong');
      setEventAppStatus(AppStatus.ERROR);
      log('home controller side error' + e.toString());
    }
  }

  Future<void> getCurrentReservation({required String id}) async {
    try {
      setUpcomingAppStatusDetail(AppStatus.LOADING);
      log('message before' + id.toString());
      await homeRepo.getCurrentUpComingReservation(id: id).then((value) {
        if (value['statusCode'].toString() == '200') {
          ReservationDetailModel res = ReservationDetailModel.fromJson(value);
          log("Current detail success " + value['statusCode'].toString());
          setUpcomingDetailsModel(res.data!);

          log('Current detail running ${res.data!.restaurant!.latitude}  +  ${res.data!.restaurant!.longitude}');
          if (res.data!.latitude == null && res.data!.longitude == null) {
            // storeUserLocation(uid: res.data!.uuid.toString());
          } else {
            storeUserLocation(
                let: res.data!.latitude.toString(),
                long: res.data!.longitude.toString());
          }

          setUpcomingAppStatusDetail(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          setUpcomingErrorDetail(value['data']['message'].toString());

          setUpcomingAppStatusDetail(AppStatus.ERROR);
        } else {
          log(value['data']['message'].toString());
          setUpcomingErrorDetail(value['data']['message'].toString());

          setUpcomingAppStatusDetail(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setUpcomingErrorDetail(error.toString());
        setUpcomingAppStatusDetail(AppStatus.ERROR);
      });
    } catch (e) {
      setUpcomingErrorDetail('something went wrong');
      setUpcomingAppStatusDetail(AppStatus.ERROR);
      log('home controller side error' + e.toString());
    }
  }

  Future<void> getAllReservation() async {
    try {
      setReservationAppStatus(AppStatus.LOADING);

      await homeRepo.getAllUpComingReservation().then((value) {
        if (value['statusCode'].toString() == '200') {
          ReservationModel res = ReservationModel.fromJson(value);
          log(value['statusCode'].toString());

          // set all past upcoming list
          setPendingEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'pending')
              .toList());
          setUpComingEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'approved')
              .toList());
          setCompletedEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'completed')
              .toList());
          // setPendingEventList(res.data!);

          setReservationAppStatus(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          setReservationEventError(value['data']['message'].toString());
          setReservationAppStatus(AppStatus.ERROR);
        } else {
          // log(value['message'].toString());
            setReservationEventError(value['message'].toString());
          setReservationAppStatus(AppStatus.ERROR);
          log('message else'); 
         
        }
      }).onError((error, stackTrace) {
        setReservationEventError(error.toString());
        log('onError'+ error.toString());
        setReservationAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      log('event controller side error' + e.toString());
      setReservationEventError('something went wrong');
      setReservationAppStatus(AppStatus.ERROR);
    }
  }

  Future<void> getPresentCurrentReservation({required String id}) async {
    try {
      setPresentStatusDetailModel(AppStatus.LOADING);
      log('message before' + id.toString());
      await homeRepo.getCurrentUpComingReservation(id: id).then((value) {
        if (value['statusCode'].toString() == '200') {
          ReservationDetailModel res = ReservationDetailModel.fromJson(value);
          log("Current detail success " + value['statusCode'].toString());
          setPresentDetailsModel(res.data!);

          log('Current detail running ${res.data!.restaurant!.latitude}  +  ${res.data!.restaurant!.longitude}');
          if (res.data!.latitude == null && res.data!.longitude == null) {
            // storeUserLocation(uid: res.data!.uuid.toString());
          } else {
            storeUserLocation(
                let: res.data!.latitude.toString(),
                long: res.data!.longitude.toString());
          }

          setPresentStatusDetailModel(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          setGetPresentErrorDetail(value['data']['message'].toString());

          setPresentStatusDetailModel(AppStatus.ERROR);
        } else {
          log(value['data']['message'].toString());
          setGetPresentErrorDetail(value['data']['message'].toString());

          setPresentStatusDetailModel(AppStatus.ERROR);
        }
      }).onError((error, stackTrace) {
        setGetPresentErrorDetail(error.toString());
        setPresentStatusDetailModel(AppStatus.ERROR);
      });
    } catch (e) {
      setGetPresentErrorDetail('something went wrong');
      setPresentStatusDetailModel(AppStatus.ERROR);
      log('home controller side error' + e.toString());
    }
  }

  Future<void> getCancelCurrentReservation({required String id}) async {
    try {
      setPresentStatusDetailModel(AppStatus.LOADING);
      // log('message before');
      await homeRepo.getCancelCurrentReservation(id: id).then((value) {
        log(value['data'].toString());

        setPresentStatusDetailModel(AppStatus.COMPLETED);
      }).onError((error, stackTrace) {
        setEventError(error.toString());
        setPresentStatusDetailModel(AppStatus.ERROR);
      });
    } catch (e) {
      log('home controller side error' + e.toString());
    }
  }

  Future<void> getApprovedCurrentReservation({required String id}) async {
    try {
      setPresentStatusDetailModel(AppStatus.LOADING);
      // log('message before');
      await homeRepo.getApprovedCurrentReservation(id: id).then((value) {
        log(value['data'].toString());
        //  getAllReservationByBookingDate();
        //               getAllReservation();
        setPresentStatusDetailModel(AppStatus.COMPLETED);
      }).onError((error, stackTrace) {
        setEventError(error.toString());
        setPresentStatusDetailModel(AppStatus.ERROR);
      });
    } catch (e) {
      log('home controller side error' + e.toString());
    }
  }

  Future<void> allCancelledPastReservation() async {
    try {
      setPastCancelledEventAppStatus(AppStatus.LOADING);

      await homeRepo.getAllCancelledPastReservation().then((value) {
        if (value['statusCode'].toString() == '200') {
          PastReservationsModel res = PastReservationsModel.fromJson(value);
          log("past canceled success " + value['statusCode'].toString());
          setCancelledEventList(res.data!);
          log(res.data!.length.toString());
          log('Past Cancelled events running');
          setPastCancelledEventAppStatus(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          setPastCancelledEventError(value['data']['message'].toString());
          setPastCancelledEventAppStatus(AppStatus.ERROR);
        } else {
           
          setPastCancelledEventError(value ['message'].toString());
          setPastCancelledEventAppStatus(AppStatus.ERROR); 
        }
      }).onError((error, stackTrace) {
        setPastCancelledEventError(error.toString());
        setPastCancelledEventAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setPastCancelledEventError('something went wrong');
      setPastCancelledEventAppStatus(AppStatus.ERROR);
      log('Home controller side error' + e.toString());
    }
  }

  Future<void> getAllPastReservation() async {
    try {
      setPastReservationEventAppStatus(AppStatus.LOADING);

      await homeRepo.getPastReservation().then((value) {
        if (value['statusCode'].toString() == '200') {
          PastReservationsModel res = PastReservationsModel.fromJson(value);
          log("past approved success " + value['statusCode'].toString());
          // setApprovedEventList(res.data!);

          // set all past upcoming list
          setPastPendingEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'pending')
              .toList());
          setPastUpComingEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'approved')
              .toList());
          setPastCompletedEventList(res.data!
              .where((e) => e.status!.toLowerCase().toString() == 'completed')
              .toList());

          log(res.data!.length.toString());
          log('Past events list is running');
          setPastReservationEventAppStatus(AppStatus.COMPLETED);
        } else if (value['statusCode'].toString() == '404') {
          setPastReservationEventError(value['data']['message'].toString());
          setPastReservationEventAppStatus(AppStatus.ERROR);
        } else {
          // log(value ['message'].toString());
           
          setPastReservationEventError(value ['message'].toString());
          setPastReservationEventAppStatus(AppStatus.ERROR);
         }
      }).onError((error, stackTrace) {
        setPastReservationEventError(error.toString());
        setPastReservationEventAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setPastReservationEventError('something went wrong');
      setPastReservationEventAppStatus(AppStatus.ERROR);
      log('home controller side error' + e.toString());
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phoneNumber,
    required String email,
    required String location,
    required String availability,
    required String tableSize,
  }) async {
    try {
      setIsLoading(true);
      final mapData = {
        "name": name,
        "email": email,
        "phone": phoneNumber,
        "no_of_tables": tableSize,
        "location": location,
        "availability": availability, // another value: busy
      };
      await homeRepo.updateEditProfile(data: mapData).then((value) {
        if (value['statusCode'].toString() == '200') {
          setIsLoading(false);
          log(value['data']['restaurant'].toString());
          _authServices.updateUserInfo(
              responseData: value['data']['restaurant']);
          fluttersToast(
              msg: value['data']['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          Get.close(2);
          // Get.offNamed(RouteName.sendEmailCodeView, arguments: [
          //   resetCodeToken,
          // ]);
        } else {
          fluttersToast(
              msg: value['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
          setIsLoading(false);
        }
      }).onError((error, stackTrace) {
        setIsLoading(false);
        fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        setError(error.toString());
      });
    } catch (e) {
      fluttersToast(
          msg: 'network error',
          bgColor: AppColors.primaryColor,
          textColor: AppColors.darkGreyColor);
      setIsLoading(false);
      log("error from resend code Method :" + e.toString());
    }
  }

  Future<void> dataRepo() async {
    try {
      await _fireStore
          .collection('Data')
          .doc('7959233945581975')
          .set({'dattata': 'hello'});
      // log(data['let'].toString() + "  " + data[''].toString());
    } catch (e) {}
  }

  Future<void> contactUsApi({
    required String name,
    required String email,
    required String phone,
    required String msg,
  }) async {
    try {
      setBookLoading(true);
      //  setAppStatus(AppStatus.LOADING);

      var bodyData = {
        "name": name,
        "email": email,
        "phone": phone,
        "message": msg,
      };
      log(bodyData.toString());
      await homeRepo.contactUsMethod(data: bodyData).then((value) async {
        log('value before checking');
        if (value['statusCode'].toString() == '200') {
          setBookLoading(false);
          // fluttersToast(
          //     msg: value['data'].toString(),
          //     bgColor: AppColors.primaryColor,
          //     textColor: AppColors.darkGreyColor);
          Get.back<void>();
          Get.dialog(ThankYouDialog());
        } else {
          setBookLoading(false);
          fluttersToast(
              msg: value['data']['message'].toString(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.darkGreyColor);
        }
      }).onError((error, stackTrace) {
        setBookLoading(false);
        // setError(error.toString());
        log('home controller side OnError');
        print(error.toString);
        fluttersToast(
            msg: 'network error',
            bgColor: AppColors.primaryColor,
            textColor: AppColors.darkGreyColor);
        // setAppStatus(AppStatus.ERROR);
      });
    } catch (e) {
      setBookLoading(false);
      // setError(e.toString());
      fluttersToast(
          msg: 'network error',
          bgColor: AppColors.primaryColor,
          textColor: AppColors.darkGreyColor);
      // setAppStatus(AppStatus.ERROR);
      log('home controller side try error' + e.toString());
    }
  }

  Future<void> storeUserLocation(
      {required String let, required String long}) async {
    try {
      kGooglePlex.value = CameraPosition(
        target:
            LatLng(double.parse(let.toString()), double.parse(long.toString())),
        zoom: 15,
      );
      listOfMarker.value.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(
              double.parse(let.toString()), double.parse(long.toString())),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

 
  Future<void> getPhoneNumbers() async {
    try {
      setContactUsAppStatus(AppStatus.LOADING);
      await homeRepo.phoneNumberRepo().then(
        (value) async {
          if (value['success'].toString() == 'true') {
            log(value['data'].toString());

            String phoneNumber = value['data']['phone'].toString();
            String whatsApp = value['data']['whatsapp'].toString();
            log(phoneNumber.toString() + "  " + whatsApp.toString());

            ContactUsModel res = ContactUsModel.fromJson(value);
            setContactUsModel(res.data!);
            setContactUsAppStatus(AppStatus.COMPLETED);
          } else {
            setContactUsAppStatus(AppStatus.ERROR);
            setContactUsError('number can not be added');
          }
        },
      ).onError((error, stackTrace) {
        setContactUsAppStatus(AppStatus.ERROR);
        setContactUsError(error.toString());
      });
    } catch (e) {
      setContactUsAppStatus(AppStatus.ERROR);
      setContactUsError(e.toString());
      log(e.toString());
    }
  }
}
