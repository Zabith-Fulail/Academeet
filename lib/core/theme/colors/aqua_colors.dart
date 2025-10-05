// aqua_colors.dart
import 'package:flutter/material.dart';
import 'main_colors.dart';
import 'app_colors.dart';

class AquaColors extends MainColors {
  AppColors aquaTheme() {
    return AppColors(
      primaryColor: Color(0xBFF3A2BE),
      primaryColor800: Color(0xFFFF4081),
      primaryColor500: Color(0xFFFFCFDF),
      surfacePrimary: Color(0xFFF0FCFB),

      secondaryColor: Color(0xFF00A6A6),

      grayColor: Color(0xFF37474F),
      neutral: Color(0xFF90A4AE),

      positiveColor: Color(0xFF00B894),
      warningColor: Color(0xFFFFC107),
      negativeColor: Color(0xFFD63031),

      whiteColor: whiteColor,
      blackColor: blackColor,
      darkGreen: darkGreen,

      primaryTextColor: Color(0xFFCF0868),
      buttonPrimaryColor: Color(0xFFFF4081),
    );
  }
}
