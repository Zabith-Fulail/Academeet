import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'main_colors.dart';

class DarkColors extends MainColors {
  AppColors darkTheme() {
    return AppColors(
      // Primary Colors
      primaryColor: Color(0xFF362979),
      primaryColor800: Color(0xFFA39AD6),

      primaryColor500: Color(0xFFC6C1E4),
      surfacePrimary: Color(0xFF1F1E25),

      // Secondary Colors
      secondaryColor: Color(0xFF008183),

      // Gray Colors
      grayColor: Color(0xFF252525),

      // Neutral Colors
      neutral: Color(0xFFA3A3A3),

      // Positive (Success) Colors
      positiveColor: Color(0xFF13823A),

      // Warning Colors
      warningColor: Color(0xFFF5C40B),

      // Negative (Error) Colors
      negativeColor: Color(0xFFB61E1D),

      // text color
      primaryTextColor: Color(0xFF362979),

      //button color
      buttonPrimaryColor: Color(0xFFC6FFA7),

      ///
      whiteColor: whiteColor,
      darkGreen: darkGreen,
      blackColor: blackColor,
    );
  }
}
