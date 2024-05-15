import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// STATIC COLORS

const Color _accentColorLight = Color(0xFFCB2937);
const Color _accentColorDark = Color(0xFFCB2937);

const Color _secondaryAccentColorLight = Color(0xFFCB2937);
const Color _secondaryAccentColorDark = Color(0xFFCB2937);

const Color primaryColorBright = Color(0xFFC2B2E5);
const Color primaryColorDark = Color(0xFF351286);

const Color successColor = Color(0xFF12C465);
const Color dangerColor = Color(0xFFCB2937);
const Color warningColor = Color(0xFFFFC960);
const Color informationColor = Color(0xFF33CBD5);

const Color lightColor = Color(0xFFF2F2F2);
const Color darkColor = Color(0xFF181818);

const Color hintTextColor = Color(0xff7c7c7c);
const Color assignmentViewButtonColor = Color(0xff65a3fe);

// Shimmer loading colors
final Color shimmerBaseColor = Colors.grey.shade300;
final Color shimmerHighlightColor = Colors.grey.shade100;
final Color shimmerContentColor = Colors.white.withOpacity(0.85);

const SystemUiOverlayStyle transparentSystemUI = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
);

const SystemUiOverlayStyle authenticationSystemUI = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: _accentColorLight,
);

const SystemUiOverlayStyle lightSystemUI = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: darkColor,
  systemNavigationBarIconBrightness: Brightness.dark,
);

const SystemUiOverlayStyle darkSystemUI = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.light,
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: darkColor,
  systemNavigationBarIconBrightness: Brightness.light,
);

class AppTheme {
  static late SystemUiOverlayStyle systemUiOverlayStyle;
  static late ColorScheme colorScheme;

  // DYNAMIC COLORS
  static late Color primaryColor;
  static late Color secondaryColor;
  static late Color textColor;
  static late Color textColorSecondary;
  static late Color backgroundColor;
  static late Color secondaryBackgroundColor;

  static setSystemUIOverlayStyle(SystemUiOverlayStyle systemUiOverlayStyle) {
    Future.delayed(const Duration(milliseconds: 30)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle),
    );
  }

  static ThemeData themeData(BuildContext context, Brightness brightness) {
    bool isLightMode = brightness == Brightness.light;

    primaryColor = isLightMode ? _accentColorLight : _accentColorDark;
    secondaryColor =
        isLightMode ? _secondaryAccentColorLight : _secondaryAccentColorDark;
    textColor = isLightMode ? darkColor : lightColor;
    textColorSecondary =
        isLightMode ? Colors.grey.shade500 : Colors.grey.shade400;
    isLightMode ? _secondaryAccentColorLight : _secondaryAccentColorDark;
    textColor = isLightMode ? darkColor : lightColor;
    textColorSecondary =
        isLightMode ? Colors.grey.shade500 : Colors.grey.shade400;
    backgroundColor = isLightMode ? Colors.white : Colors.black;
    secondaryBackgroundColor = isLightMode ? lightColor : darkColor;

    // systemUiOverlayStyle = isLightMode ? lightSystemUI : darkSystemUI;

    // setSystemUIOverlayStyle(systemUiOverlayStyle);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        primary: primaryColor,
      ),
      brightness: brightness,
      scaffoldBackgroundColor: secondaryBackgroundColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppTheme.secondaryBackgroundColor,
        toolbarHeight: 46,
      ),
    );
  }
}
