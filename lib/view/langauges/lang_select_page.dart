 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant/data/model/langauage.dart';
import 'package:restaurant/generalWidgets/my_language.dart';
import 'package:restaurant/generalWidgets/primary_button.dart';
 
import 'package:restaurant/res/colors.dart';
import 'package:restaurant/res/icons.dart';
import 'package:restaurant/res/typography.dart';
import 'package:restaurant/view/onBoardingView/onboard_view.dart';

class LanguageSelectPage extends StatefulWidget {
  LanguageSelectPage({super.key});

  @override
  State<LanguageSelectPage> createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  int selectValue = 0;
  bool isSelectValue = false;
  LanguageModel languageModel = langList[0];
  // final ac = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    width: 90.w,
                    height: 90.h,
                    child: SvgPicture.asset(
                      AppIcons.languageIcon,
                    )),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'select language'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 23.sp, color: AppColors.whiteColor),
              ),
              SizedBox(
                height: 12.h,
              ),
              Wrap(
                children: List.generate(
                    langList.length,
                    (index) => MySelectLanguage(
                        onTab: () {
                          setState(() {
                            selectValue = index;
                            isSelectValue = true;
                          });
                        },
                        image: langList[index].image,
                        text: langList[index].langName,
                        color: selectValue == index
                            ? AppColors.whiteColor
                            : AppColors.lightGreyColor)),
              ),
              // ac.firebaseUser == null || ac.firebaseUser!.isAnonymous
              //     ?
              SizedBox(
                height: 123.h,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: PrimaryButton(
                  onTap: () async {
                    print(" before button pressed.. " +
                        languageModel.locale +
                        "_" +
                        languageModel.langCode);
                    checkSaveLang(languageModel);
                    Get.offAll(() => OnBoardingView());
                  },
                  width: 360.w,
                  childWidget: Text(
           'select'.tr,
              style: CustomStyle.textSemiBold12.copyWith(
                color: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ) ,
 
                  bgColor: isSelectValue
                      ? AppColors.whiteColor
                      : AppColors.lightGreyColor,
                  borderRadius: 25.r,
                  height: 48.h,
                  elevation: 0,
                ),
              )
              // : Padding(
              //     padding: EdgeInsets.only(top: 10.0.h),
              //     child: PrimaryButton(
              //       onTap: () async {
              //         // print(" before button pressed.. " +
              //         //     languageModel.locale +
              //         //     "_" +
              //         //     languageModel.langCode);

              //         checkSaveLang(languageModel);
              //         Get.back<void>();
              //       },
              //       width: 300.w,
              //       text: 'select'.tr,
              //       textColor: AppColors.whiteColor,
              //       bgColor: AppColors.primaryColor,
              //       borderRadius: 100.r,

              //       height: 62.h,
              //       elevation: 0,

              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }

  void checkSaveLang(LanguageModel languageModel) {
    if (languageModel.locale == 'en') {
      print(languageModel.langName);
      // lc.changeLanguage(Locale('en'));
      Hive.box('box').put('local', 'en');
      Hive.box('box').put('lang_code', languageModel.langCode);
      Get.updateLocale(Locale('en', languageModel.langCode));
    } else {
      print(languageModel.langName);
      Get.updateLocale(Locale('de', languageModel.langCode));
      Hive.box('box').put('local', 'de');
      Hive.box('box').put('lang_code', languageModel.langCode);
    }
  }
}
