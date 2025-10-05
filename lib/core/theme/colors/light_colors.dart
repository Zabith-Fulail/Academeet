import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'main_colors.dart';

class LightColors  extends MainColors{
  AppColors lightTheme() {
    return AppColors(
      // Primary Colors
        primaryColor: Color(0xFF287870),
        primaryColor800: Color(0xFF50B2AA),

        primaryColor500: Color(0xFFC0E4E1),
        surfacePrimary: Color(0xFFF5F5F5),


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


        // text colors
        primaryTextColor: Color(0xFF046259),
        buttonPrimaryColor: Color(0xFF029386),
        whiteColor: whiteColor,
        blackColor: blackColor,
      darkGreen: darkGreen,






    );
  }
}






