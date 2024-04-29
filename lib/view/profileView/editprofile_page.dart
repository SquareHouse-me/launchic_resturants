import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/generalWidgets/countrycode_widget.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final uc = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    nameC.text = Hive.box('userBox').get('restaurantName').toString();
    String numData = Hive.box('userBox').get('restaurantPhone').toString();
    email.text = Hive.box('userBox').get('restaurantEmail').toString();
    location.text = Hive.box('userBox').get('restaurantLocation').toString();
    availability.text =
        Hive.box('userBox').get('restaurantAvailability').toString();
    tablesSize.text = Hive.box('userBox').get('restaurantTables').toString();
    numData.contains('null') ? phoneC.clear() : false;

    phoneC.text = phoneC.text.length < 8
        ? numData
        : numData.substring(numData.length - 8);
    // dataDec.text = Hive.box('userBox').get('restaurantAvailability').toString();
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tablesSize = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController availability = TextEditingController();
  TextEditingController dataDec = TextEditingController();
  RxString countryCode = '965'.obs;
  RxString countryEmoji = '🇰🇼'.obs;
  final _formKey = GlobalKey<FormState>();
  String urlImage = '';

  @override
  Widget build(BuildContext context) {
    final TextTheme appTextStyle = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          title: Text(
            'Edit Profile'.tr,
            style: appTextStyle.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.blackColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h)
                .copyWith(top: 0.h),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeIn(
                      child: Text(
                        'nameFieldText'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        onTapOutside: (p0) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        hintColor: AppColors.darkGreyColor,
                        textInputAction: TextInputAction.next,
                        controller: nameC,
                        styleColor: AppColors.blackColor,
                        hintText: 'nameHintText'.tr,
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]+')),
                        ],
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.person,
                            color: AppColors.blackColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (val.length > 30) {
                            return 'nameTooLong'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'emailFieldText'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        onTapOutside: (p0) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: email,
                        hintText: 'emailHintText'.tr,
                        hintColor: AppColors.darkGreyColor,
                        obscureText: false,
                        styleColor: AppColors.blackColor,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.mail_solid,
                            color: AppColors.blackColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                              .hasMatch(val)) {
                            return 'validEmail'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'phoneFieldText'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => CountryCodeWidget(
                          hintColor: AppColors.darkGreyColor,
                          titleColor: AppColors.blackColor,
                          defaultTitleColor: AppColors.blackColor,
                          styleColor: AppColors.blackColor,
                          enabledBorder: AppColors.lightGreyColor,
                          focusedBorder: AppColors.blackColor,
                          iconData: AppColors.blackColor,
                          controller: phoneC,
                          hintText: 'phoneHintText'.tr,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                              exclude: <String>['KN', 'MF'],
                              favorite: <String>['SE'],
                              //Optional. Shows phone code before the country name.
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                countryCode.value = country.phoneCode;
                                countryEmoji.value = country.flagEmoji;
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                // Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'searchLabelText'.tr,
                                  hintText: 'searchHintText'.tr,
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                          countryCode: countryCode.value,
                          countryEmoji: countryEmoji.value,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'validatorText'.tr;
                            } else if (val.length > 8) {
                              return 'phoneValidatorText'.tr;
                            } else if (val.length < 8) {
                              return 'phoneShortValidatorText'.tr;
                            }
                            return null;
                          },
                        )),
                    FadeIn(
                      child: Text(
                        'Table Size'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        onTapOutside: (p0) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: tablesSize,
                        hintText: 'enter table size'.tr,
                        hintColor: AppColors.darkGreyColor,
                        obscureText: false,
                        styleColor: AppColors.blackColor,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.table_badge_more,
                            color: AppColors.blackColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'Location'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        onTapOutside: (p0) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: location,
                        hintText: 'location'.tr,
                        hintColor: AppColors.darkGreyColor,
                        obscureText: false,
                        styleColor: AppColors.blackColor,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.location,
                            color: AppColors.blackColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          }
                          return null;
                        }),
                    FadeIn(
                      child: Text(
                        'Availability'.tr,
                        style: CustomStyle.textMedium14.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimaryTextField(
                        onTapOutside: (p0) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        enabledBorder: AppColors.lightGreyColor,
                        focusedBorder: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: availability,
                        hintText: 'availability'.tr,
                        hintColor: AppColors.darkGreyColor,
                        obscureText: false,
                        styleColor: AppColors.blackColor,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.calendar,
                            color: AppColors.blackColor,
                            size: 20.sp,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'validatorText'.tr;
                          }
                          return null;
                        }),
                     
                  ],
                ),
                Obx(() => FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 800),
                      child: PrimaryButton(
                        elevation: 0,
                        onTap: uc.isLoading.value
                            ? () {
                                log('message');
                              }
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                   
                                  if (countryCode.isEmpty) {
                                    Get.snackbar(
                                        backgroundColor:
                                            AppColors.whiteLightColor,
                                        'Warning',
                                        'please select the country code');
                                  } else {
                                    await uc.updateUserData(
                                      name: nameC.text.trim(),
                                      phoneNumber:
                                          phoneC.text.trim().toString(),
                                      email: email.text.trim().toString(),
                                      availability:
                                          availability.text.trim().toString(),
                                      location: location.text.trim().toString(),
                                      tableSize:
                                          tablesSize.text.trim().toString(),
                                    );
                                  }
                                }
                              },
                        childWidget: uc.isLoading.value
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    strokeWidth:
                                        2.0, // Adjust the thickness of the indicator

                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.whiteColor),
                                  ),
                                ),
                              )
                            : Text(
                                'update'.tr,
                                style: CustomStyle.textSemiBold12.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        bgColor: AppColors.blackColor,
                        borderRadius: 12.r,
                        height: 48.h,
                      ),
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
