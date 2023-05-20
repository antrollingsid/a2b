import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main/utils/Colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(colorPrimary),
    primaryColor: Color.fromRGBO(17, 63, 118, 1),
    scaffoldBackgroundColor: AppColors.backgroundLightMode,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: Colors.black),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    dividerColor: viewLineColor,
    cardColor: Colors.white,
    tabBarTheme: const TabBarTheme(labelColor: Colors.black),
    appBarTheme: AppBarTheme(
      color: colorPrimary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: colorPrimary),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 19, 128, 43),
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(colorPrimary),
    primaryColor: const Color.fromRGBO(187, 134, 252, 1.0),
    scaffoldBackgroundColor: AppColors.buttonStroke,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: AppColors.backgroundLightMode),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.black,
    // textTheme: TextTheme(),
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,
    tabBarTheme: const TabBarTheme(labelColor: Color.fromARGB(255, 7, 48, 130)),
    appBarTheme: const AppBarTheme(
      color: scaffoldSecondaryDark,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: scaffoldSecondaryDark,
      ),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    snackBarTheme: const SnackBarThemeData(backgroundColor: appButtonColorDark),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: appButtonColorDark),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 19, 128, 43),
    ),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static of(BuildContext context) {}
}
