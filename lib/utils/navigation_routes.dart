import 'package:flutter/material.dart';

import '../features/presentation/views/academeet/book_appointment_view.dart';
import '../features/presentation/views/academeet/booking_date_time_view.dart';
import '../features/presentation/views/academeet/booking_success_view.dart';
import '../features/presentation/views/academeet/payment_view.dart';
import '../features/presentation/views/academeet/academeet_view.dart';
import '../features/presentation/views/activities/activities_view.dart';
import '../features/presentation/views/change_appointment/change_appointment_view.dart';
import '../features/presentation/views/home/gender_selection_view.dart';
import '../features/presentation/views/home/main_navigation_view.dart';
import '../features/presentation/views/home/student_home_screen.dart';
import '../features/presentation/views/notifications/notification_view.dart';
import '../features/presentation/views/otp_verification/data/otp_verify_view_args.dart';
import '../features/presentation/views/otp_verification/otp_verify_view.dart';
import '../features/presentation/views/sign_in/log_in_view.dart';
import '../features/presentation/views/sign_up/mobile_number_view.dart';
import '../features/presentation/views/sign_up/sign_up_view.dart';
import '../features/presentation/views/splash_screen/splash_screen.dart';
import '../features/presentation/views/user_profile/user_profile_edit_view.dart';
import '../features/presentation/views/user_profile/user_profile_view.dart';

class Routes {
  static const String kSplashView = 'kSplashView';
  static const String kLogInView = 'kLogInView';
  static const String kSignUpView = 'kSignUpView';
  static const String kMobileNumberView = 'kMobileNumberView';
  static const String kOtpVerifyView = 'kOtpVerifyView';
  static const String kHomeDashboard = 'kHomeDashboard';
  static const String kAcademeetView = 'kAcademeet';
  static const String kBookAppointmentView = 'kBookAppointmentView';
  static const String kBookingDateTimeView = 'kBookingDateTimeView';
  static const String kPaymentView = 'kPaymentView';
  static const String kBookingSuccessView = 'kBookingSuccessView';
  static const String kUserProfileView = 'kUserProfileView';
  static const String kUserProfileEditView = 'kUserProfileEditView';
  static const String kActivitiesView = 'kActivitiesView';
  static const String kGenderSelectionView = 'kGenderSelectionView';
  static const String kChangeAppointmentView = 'kChangeAppointmentView';
  static const String kNotificationView = 'kNotificationView';
  static const String kStudentHomeScreen = 'kStudentHomeScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplashView:
        return _slideTransition(const SplashScreen(), kSplashView);
      case kLogInView:
        return MaterialPageRoute(
          builder: (_) => LogInView(),
          settings: const RouteSettings(name: kLogInView),
        );
      // return _slideTransition(const SignInView(), kSignInView);
      case kSignUpView:
        return _slideTransition(const SignUpView(), kSignUpView);
      case kMobileNumberView:
        return _slideTransition(const MobileNumberView(), kMobileNumberView);
      case kOtpVerifyView:
        return _slideTransition(
          OtpVerifyView(
            otpVerifyViewArgs: settings.arguments as OtpVerifyViewArgs,
          ),
          kOtpVerifyView,
        );
      case kHomeDashboard:
        return _slideTransition(const MainNavigation(), kHomeDashboard);
      case kAcademeetView:
        return _slideTransition(const AcadeMeetView(), kAcademeetView);
      case kBookAppointmentView:
        return _slideTransition(BookAppointmentView(), kBookAppointmentView);
      case kBookingDateTimeView:
        return _slideTransition(BookingDateTimeView(), kBookingDateTimeView);
      case kPaymentView:
        return _slideTransition(PaymentView(), kPaymentView);
      case kBookingSuccessView:
        return _slideTransition(BookingSuccessView(), kBookingSuccessView);
      case kUserProfileView:
        return _slideTransition(UserProfileView(), kUserProfileView);
      case kGenderSelectionView:
        return _slideTransition(GenderSelectionView(), kGenderSelectionView);
      case kChangeAppointmentView:
        return _slideTransition(
          ChangeAppointmentView(),
          kChangeAppointmentView,
        );
      case kNotificationView:
        return _slideTransition(NotificationView(), kNotificationView);
      case kStudentHomeScreen:
        return _slideTransition(StudentHomeScreen(), kStudentHomeScreen);
      case kUserProfileEditView:
        return _slideTransition(
          UserProfileEditView(
            userProfileEditViewArgs:
                settings.arguments as UserProfileEditViewArgs,
          ),
          kUserProfileEditView,
        );
      case kActivitiesView:
        return _slideTransition(ActivitiesView(), kActivitiesView);
      default:
        return _slideTransition(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          'undefined',
        );
    }
  }

  static Route _slideTransition(Widget page, String name) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0); // slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
