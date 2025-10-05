import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? primaryColor800;

  final Color? primaryColor500;

  final Color? secondaryColor;

  final Color? grayColor;

  final Color? neutral;

  final Color? positiveColor;

  final Color? warningColor;

  final Color? negativeColor;

  final Color? whiteColor;
  final Color? blackColor;
  final Color? darkGreen;

  final Color? surfacePrimary;

  final Color? buttonPrimaryColor;
  final Color? primaryTextColor;

  const AppColors({
    required this.primaryColor,
    required this.primaryColor800,
    required this.primaryColor500,
    required this.secondaryColor,
    required this.grayColor,
    required this.neutral,
    required this.positiveColor,
    required this.warningColor,
    required this.negativeColor,
    required this.whiteColor,
    required this.blackColor,
    required this.darkGreen,
    required this.surfacePrimary,
    required this.primaryTextColor,
    required this.buttonPrimaryColor,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? primaryColor800,
    Color? primaryColor500,
    Color? secondaryColor,
    Color? grayColor,
    Color? neutral,
    Color? positiveColor,
    Color? warningColor,
    Color? negativeColor,
    Color? whiteColor,
    Color? blackColor,
    Color? surfacePrimary,
    Color? buttonPrimaryColor,
    Color? primaryTextColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColor800: primaryColor800 ?? this.primaryColor800,
      primaryColor500: primaryColor500 ?? this.primaryColor500,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      grayColor: grayColor ?? this.grayColor,
      neutral: neutral ?? this.neutral,
      positiveColor: positiveColor ?? this.positiveColor,
      warningColor: warningColor ?? this.warningColor,
      negativeColor: negativeColor ?? this.negativeColor,
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      buttonPrimaryColor: buttonPrimaryColor ?? this.buttonPrimaryColor,
      darkGreen: darkGreen ?? this.darkGreen
      ,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      primaryColor800: Color.lerp(primaryColor800, other.primaryColor800, t),
      primaryColor500: Color.lerp(primaryColor500, other.primaryColor500, t),
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      grayColor: Color.lerp(grayColor, other.grayColor, t),
      neutral: Color.lerp(neutral, other.neutral, t),
      positiveColor: Color.lerp(positiveColor, other.positiveColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      negativeColor: Color.lerp(negativeColor, other.negativeColor, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
      darkGreen: Color.lerp(darkGreen, other.darkGreen, t),
      primaryTextColor: primaryTextColor,
      buttonPrimaryColor: buttonPrimaryColor,
    );
  }
}
