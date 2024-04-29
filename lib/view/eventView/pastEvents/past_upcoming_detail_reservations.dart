import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant/data/model/past_reservation_model.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';

class PastUpComingDetailView extends StatefulWidget {
  const PastUpComingDetailView({
    super.key,
  });

  @override
  State<PastUpComingDetailView> createState() => _PastUpComingDetailViewState();
}

class _PastUpComingDetailViewState extends State<PastUpComingDetailView> {
 
  PastList? pastList;
   
  @override
  void initState() {
    super.initState();
    pastList = Get.arguments[0];
    
  }

  final pastHomeC = Get.find<HomeController>();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: NetworkImage(
                            pastList!.restaurant!.banner.toString(),
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
                              pastList!.restaurant!.location.toString(),
                              style: CustomStyle.textBold30.copyWith(
                                  color: AppColors.light100BlackColor,
                                  fontSize: 26.sp),
                            ),
                            subtitle: Text(
                              pastList!.restaurant!.location.toString(),
                              style: CustomStyle.textRegular15.copyWith(
                                color: AppColors.light100BlackColor,
                              ),
                            ),
                          ),
                        ),
                         
                        
                      ],
                    )
                  ],
                ),
                ReusableRow(
                  title: 'Restaurant Name  :',
                  value: pastList!.restaurant!.name.toString(),
                ),
                ReusableRow(
                  title: 'User Name  :',
                  value: pastList!.customer.toString(),
                ),
                ReusableRow(
                  title: 'Booking Date  :',
                  value: pastList!.bookingDate.toString(),
                ),
                ReusableRow(
                  title: 'Order Time  :',
                  value: pastList!.bookingTime.toString(),
                ),
                ReusableRow(
                  title: 'Party Size  :',
                  value: pastList!.partySize.toString(),
                ),
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
                                Container(
                          
                                      padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: pastHomeC.getContainerOrderStatusColor(
                                  pastList!.status.toString())),
                          child: Text(
                            pastList!.status ?? 'empty',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: pastHomeC
                                  .getStatusColor(pastList!.status.toString()),
                            ),
                          ),
                        ),
                              ],
                            ),
                          )
        //         Obx(() =>     pastList. == null
        //                         ? Stack(
        //                                   children: [
                                         
        //                                     BackdropFilter(
        //                                       filter: ImageFilter.blur(),
        //                                       child: Container(
        //                                         decoration: BoxDecoration(
        //                                             color: Colors.white,
        //                                             shape: BoxShape.circle),
        //                                         height: 230.0.h,
        //                                         child: GoogleMap(
        //                                           indoorViewEnabled: false,
        //                                           liteModeEnabled: false, initialCameraPosition: CameraPosition(
        //   target: LatLng( 0.0,
        //     0.0),
        //   zoom: 15,
        // ),
                                                   
        //                                         ),
        //                                       ),
        //                                     ),
        //                                      Positioned(
        //                                       top: 120.h,
        //                                       left: 50.w,
        //                                        child: Center(
        //                                          child: Text(
        //                                                                                 'no map Added yet',
        //                                                                                style: CustomStyle.textBold24.copyWith(
        //                                                                                  color: AppColors.light100BlackColor,
        //                                                                                ),
        //                                                                              ),
        //                                        ),
        //                                      ),],
        //                                 )
        //                         : Container(
        //                               decoration: BoxDecoration(
        //                                   color: Colors.white,
        //                                   shape: BoxShape.circle),
        //                               height: 230.0.h,
        //                               child: GoogleMap(
        //                                 indoorViewEnabled: false,
        //                                 liteModeEnabled: false,
        //                                 initialCameraPosition:
        //                                     pastHomeC.kGooglePlex.value!,
        //                                 markers: Set<Marker>.of(
        //                                     pastHomeC.listOfMarker.value),
        //                               ),
        //                             )),
                 
              ],
            ),
          ),
        ),
      ),
    );
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
