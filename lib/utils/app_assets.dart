
import '../core/theme/theme_service.dart';

const String kSVGType = '.svg';
const String kPngType = '.png';
const String kWebpType = '.webp';
const String kAniType = '.json';

class AppAssets {
  static ThemeType _themeType = ThemeType.SYSTEM;

  void setTheme(ThemeType? themeType) {
    _themeType = themeType ?? ThemeType.SYSTEM;
  }

  static String themeType(String path) {
    switch (_themeType) {
      case ThemeType.LIGHT:
        return 'assets/light/$path';
      case ThemeType.DARK:
        return 'assets/dark/$path';
      case ThemeType.SYSTEM:
      default:
        return 'assets/light/$path';
    }
  }

  // Base path for PNG images
  static String get kPNGImagePath => themeType("png/");

  // Base path for PNG bank images
  static String get kPNGBanksImagePath => themeType("png/banks/");

  // Base path for SVG images
  static String get kSVGImagePath => themeType("svg/");

  // Base path for SVG bank images
  static String get kSVGBanksImagePath => themeType("svg/banks/");

  // Base path for WEBP images
  static String get kWEBPImagePath => themeType("webp/");

  // Base path for animations
  static String get kAnimImagePath => themeType("animations/");

  ///ANIMATION
  static String get loadingAnimation => '${kAnimImagePath}loadingAnimation$kAniType';
  static String get splashAnimation => '${kAnimImagePath}splashAnimation$kAniType';

  ///PNG
  static String get mainMenuBackground => '${kPNGImagePath}mainMenuBackground$kPngType';
  static String get splashIcon => '${kPNGImagePath}splashIcon$kPngType';
  static String get iconBook => '${kPNGImagePath}iconBook$kPngType';

  ///WEBP

  // static String get loginBackground => '${kWEBPImagePath}loginBackground${kWebpType}';
  // static String get initialBackground => '${kWEBPImagePath}initialBackground${kWebpType}';
  static String get mainMenuBackgroundImage => '${kWEBPImagePath}mainMenuBackgorund$kWebpType';

  ///SVG

  static String get iconUnisex => '${kSVGImagePath}iconUnisex$kSVGType';
  // static String get iconBook => '${kSVGImagePath}iconBook$kSVGType';

}
