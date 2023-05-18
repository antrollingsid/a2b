import 'package:flutter/material.dart';

class AppColors {
  static const Color onBackgroundDark = Colors.white;
  static const Color backgroundLightMode = Color.fromRGBO(255, 255, 255, 1);
  static const Color secondaryBlue = Color.fromRGBO(209, 101, 69, 1.0);
  static const Color buttonStroke = Color.fromRGBO(18, 18, 18, 1.0);
  static const Color buttonYellow = Color.fromRGBO(255, 246, 117, 1.0);
  static const Color primary = Color.fromRGBO(209, 101, 69, 1.0);
  static const Color purple = Color.fromRGBO(187, 134, 252, 1.0);
  static const Color buttonDark = Color.fromRGBO(23, 23, 23, 1.0);
  static const Color buttonBlue = Color.fromRGBO(17, 63, 118, 1.0);
  static const Color textBlack = Colors.black;
  static const Color secondary = Color.fromRGBO(209, 101, 69, 1.0);
  static const Color buttonRed = Color.fromRGBO(244, 48, 12, 1.0);
  static const Color errorDark = Color.fromRGBO(207, 102, 121, 1.0);
  static const Color textGrey = Color.fromRGBO(151, 151, 151, 1.0);
  static const Color textBlue = Color.fromRGBO(17, 63, 118, 1.0);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLight = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);
  static const customIconButtonBackgroundLight =
      Color.fromARGB(255, 245, 243, 243);
  static const customIconButtonBackgroundDark = Colors.white10;
}

const scaffoldSecondaryDark = Color(0xFF1E1E1E);
const scaffoldColorDark = Color(0xFF090909);
const scaffoldColorLight = Colors.white;
const appButtonColorDark = Color(0xFF282828);
const dividerColor = Color(0xFFD3D3D3);
Color colorPrimary = const Color(0xFF573391);
Color borderColor = const Color(0xFFEAEAEA);

abstract class _LightColors {
  static const background = Colors.white;
  static const card = AppColors.cardLight;
}

abstract class _DarkColors {
  static const background = Color(0xFF1B1E1F);
  static const card = AppColors.cardDark;
}
