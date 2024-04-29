import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:restaurant/routers/routers_name.dart';
import 'package:restaurant/view/authView/changepassword_page.dart';
import 'package:restaurant/view/authView/forget_view.dart';
import 'package:restaurant/view/authView/password_changed_view.dart';
import 'package:restaurant/view/authView/resetpassword_view.dart';
import 'package:restaurant/view/authView/sendemail_verification_view.dart';

import 'package:restaurant/view/authView/signin_view.dart';

import 'package:restaurant/view/dashboardView/up_coming_detail_view.dart';
import 'package:restaurant/view/eventView/pastEvents/past_reservation.dart';
import 'package:restaurant/view/eventView/pastEvents/past_upcoming_detail_reservations.dart';
import 'package:restaurant/view/eventView/presentEvents/present_detail_view.dart';
 import 'package:restaurant/view/landingView/landing_view.dart';
import 'package:restaurant/view/onBoardingView/onboard_view.dart';
import 'package:restaurant/view/profileView/account_settings.dart';
import 'package:restaurant/view/profileView/editprofile_page.dart';
import 'package:restaurant/view/profileView/profile_settings.dart';
import 'package:restaurant/view/contactView/contact_us.dart';
 
class AppRoutes {
  static appRoute() => [
        GetPage(
          name: RouteName.splashPage,
          page: () => const OnBoardingView(),
        ),
        GetPage(
          name: RouteName.signInView,
          page: () => SignInView(),
        ),
        GetPage(
          name: RouteName.landingView,
          page: () => const LandingView(),
        ),
        GetPage(
          name: RouteName.pastReservationScreen,
          page: () => PastReservationScreen(),
        ),
        GetPage(
          name: RouteName.accountingSettings,
          page: () => const AccountingSettings(),
        ),
        GetPage(name: RouteName.contactUs, page: () => const ContactUs()),
        GetPage(name: RouteName.editProfilePage, page: () => EditProfilePage()),
        GetPage(name: RouteName.profileSettings, page: () => ProfileSettings()),
        GetPage(
            name: RouteName.changePasswordPage,
            page: () => ChangePasswordPage()),
        GetPage(
          name: RouteName.forgetView,
          page: () => const ForgetView(),
        ),
        GetPage(
          name: RouteName.sendEmailCodeView,
          page: () => const SendEmailCodeView(),
        ),
        GetPage(
          name: RouteName.resetPasswordView,
          page: () => const ResetPasswordView(),
        ),
        GetPage(
          name: RouteName.passChangedView,
          page: () => const PassChangedView(),
        ),
        GetPage(
            name: RouteName.upComingDetailView,
            page: () => UpComingDetailView()),
        GetPage(
            name: RouteName.pastUpComingDetailView,
            page: () => PastUpComingDetailView()),
            GetPage(
            name: RouteName.kPresentDetailView,
            page: () => PresentDetailView()),
             
      ];
}
