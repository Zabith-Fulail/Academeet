import 'package:flutter/material.dart';

import '../features/presentation/views/booking/book_tutor_screen.dart';
import '../features/presentation/views/booking/booking_date_time_view.dart';
import '../features/presentation/views/booking/booking_success_view.dart';
import '../features/presentation/views/booking/language_selection_view.dart';
import '../features/presentation/views/booking/level_selection_view.dart';
import '../features/presentation/views/booking/payment_view.dart';
import '../features/presentation/views/booking/select_subject_category.dart';
import '../features/presentation/views/booking/subject_selection_view.dart';
import '../features/presentation/views/home/home_screen_dashboard.dart';
import '../features/presentation/views/otp_verification/data/otp_verify_view_args.dart';
import '../features/presentation/views/otp_verification/otp_verify_view.dart';
import '../features/presentation/views/sign_in/log_in_view.dart';
import '../features/presentation/views/sign_up/mobile_number_view.dart';
import '../features/presentation/views/sign_up/sign_up_view.dart';
import '../features/presentation/views/splash_screen/splash_screen.dart';
import '../features/presentation/views/tutor/tutor_details_screen.dart';

class Routes {
  static const String kSplashView = 'kSplashView';
  static const String kLogInView = 'kLogInView';
  static const String kSignUpView = 'kSignUpView';
  static const String kMobileNumberView = 'kMobileNumberView';
  static const String kOtpVerifyView = 'kOtpVerifyView';
  static const String kBookTutorScreen = 'kBookTutorScreen';
  static const String kBookingDateTimeView = 'kBookingDateTimeView';
  static const String kPaymentView = 'kPaymentView';
  static const String kBookingSuccessView = 'kBookingSuccessView';
  static const String kStudentHomeScreen = 'kStudentHomeScreen';
  static const String kTutorDetailScreen = 'kTutorDetailScreen';
  static const String kLevelSelectionView = 'kLevelSelectionView';
  static const String kSubjectSelectionView = 'kSubjectSelectionView';
  static const String kSelectSubjectCategory = 'kSelectSubjectCategory';
  static const String kLanguageSelectionView = 'kLanguageSelectionView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplashView:
        return _slideTransition(const SplashScreen(), kSplashView);
      case kLogInView:
        return MaterialPageRoute(
          builder: (_) => LogInView(),
          settings: const RouteSettings(name: kLogInView),
        );
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
      case kBookTutorScreen:
        return _slideTransition(BookTutorScreen(), kBookTutorScreen);
      case kBookingDateTimeView:
        return _slideTransition(BookingDateTimeView(), kBookingDateTimeView);
      case kPaymentView:
        return _slideTransition(PaymentView(), kPaymentView);
      case kBookingSuccessView:
        return _slideTransition(BookingSuccessView(), kBookingSuccessView);
      case kStudentHomeScreen:
        return _slideTransition(HomeScreen(), kStudentHomeScreen);
      case kSelectSubjectCategory:
        return _slideTransition(
          SelectSubjectCategoryView(),
          kSelectSubjectCategory,
        );
      case kTutorDetailScreen:
        return _slideTransition(
          TutorDetailScreen(tutor: settings.arguments as Tutor),
          kTutorDetailScreen,
        );
      case kLanguageSelectionView:
        return _slideTransition(
          LanguageSelectionView(),
          kLanguageSelectionView,
        );
      case kLevelSelectionView:
        return _slideTransition(
          LevelSelectionView(
            selectedLanguage: settings.arguments as LanguageEntity,
          ),
          kLevelSelectionView,
        );

        case kSubjectSelectionView:
        return _slideTransition(
          SubjectSelectionView(
            subjectSelectionViewArgs: settings.arguments as SubjectSelectionViewArgs,
          ),
          kLevelSelectionView,
        );
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
