// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant/data/status.dart';
import 'package:restaurant/generalWidgets/countrycode_widget.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
import 'package:restaurant/generalWidgets/primarytextfield.dart';
import 'package:restaurant/generalWidgets/thankyou_dialog.dart';
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/viewModel/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final messageController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  RxString countryCode = '965'.obs;
  RxString countryEmoji = '🇰🇼'.obs;
  bool isEnable = false;
  final _formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getPhoneNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // title: Text(
        //   'if you have any issue, please click on  the given below option ',
        //   style: CustomStyle.textSemiBold12.copyWith(
        //     color: AppColors.blackColor,
        //   ),
        // ),
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Text(
                    //         'contactText'.tr,
                    //         style: CustomStyle.textBold36.copyWith(color: AppColors.blackColor),
                    //       ),

                    Obx(() => homeController.contactUsAppStatus ==
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
                        : homeController.contactUsAppStatus == AppStatus.ERROR
                            ? Center(
                                child: Text(
                                    homeController.contactUsError.toString()),
                              )
                            : Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                        backgroundColor: AppColors.goldenColor,
                                        child: Text(
                                          '1',
                                          style: CustomStyle.textRegular12
                                              .copyWith(
                                            color: AppColors.whiteColor,
                                            fontSize: 16.sp,
                                          ),
                                        )),
                                    title: Text(
                                      'call using local phone number',
                                      style: CustomStyle.textBold24.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onTap: () {
                                      String url =
                                          "tel:${homeController.contactUsModel!.phone.toString()}";
                                      launchUrl(
                                        Uri.parse(url),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    subtitle: Text(
                                      homeController.contactUsModel!.phone
                                          .toString(),
                                      style: CustomStyle.textRegular12.copyWith(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    trailing: Icon(
                                      CupertinoIcons.phone,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                        backgroundColor: AppColors.goldenColor,
                                        child: Text(
                                          '2',
                                          style: CustomStyle.textRegular12
                                              .copyWith(
                                            color: AppColors.whiteColor,
                                            fontSize: 16.sp,
                                          ),
                                        )),
                                    title: Text(
                                      'Text using Social Media',
                                      style: CustomStyle.textBold24.copyWith(
                                        color: AppColors.blackColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    subtitle: Text(
                                        homeController.contactUsModel!.whatsapp
                                            .toString(),
                                        style:
                                            CustomStyle.textRegular12.copyWith(
                                          color: Colors.grey,
                                          fontSize: 16.sp,
                                        )),
                                    trailing: Icon(
                                      CupertinoIcons.phone_circle,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      String url =
                                          "https://wa.me/${homeController.contactUsModel!.whatsapp.toString()}?text=Hello I am restaurant owner";
                                      launchUrl(Uri.parse(url),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  ),
                                ],
                              )),
                  ],
                ),
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
                        controller: nameController,
                        styleColor: AppColors.blackColor,
                        hintText: 'nameHintText'.tr,
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
                    Text(
                      'phoneFieldText'.tr,
                      style: CustomStyle.textMedium14.copyWith(
                        color: AppColors.blackColor,
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
                          controller: phoneController,
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
                        controller: emailController,
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
                        'message'.tr,
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
                        styleColor: AppColors.blackColor,
                        textInputAction: TextInputAction.next,
                        controller: messageController,
                        hintText: 'messageTextDes'.tr,
                        hintColor: AppColors.darkGreyColor,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        prefixIcon: FadeIn(
                          child: Icon(
                            CupertinoIcons.text_aligncenter,
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
                        onTap: homeController.isBookLoading.value
                            ? () {}
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await homeController.contactUsApi(
                                      name: nameController.text.toString(),
                                      email: emailController.text.toString(),
                                      phone: countryCode +
                                          phoneController.text.toString(),
                                      msg: messageController.text.toString());
                                }
                              },
                        childWidget: homeController.isBookLoading.value
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.transparent,
                                    strokeWidth:
                                        2.0, // Adjust the thickness of the indicator

                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.whiteColor),
                                  ),
                                ),
                              )
                            : Text(
                                'submitText'.tr,
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
                SizedBox(
                  height: 34.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
