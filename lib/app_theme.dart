import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'main/utils/allConstants.dart';

class AppTheme {
  //
  AppTheme._();
// Color.fromRGBO(17, 63, 118, 1)

  static final ThemeData lightTheme = ThemeData(
    // colorScheme: const ColorScheme(
    //   background: AppColors.backgroundLight,
    //   error: AppColors.errorDark,
    //   onBackground: Color.fromRGBO(13, 13, 13, 1),
    //   onError: AppColors.backgroundLight,
    //   onPrimary: Color.fromRGBO(13, 13, 13, 1),
    //   onSecondary: Color.fromRGBO(224, 124, 121, 1),
    //   onSurface: Color.fromRGBO(13, 13, 13, 1),
    //   primary: Color.fromRGBO(224, 124, 121, 1),
    //   secondary: Color.fromRGBO(13, 13, 13, 1),
    //   brightness: Brightness.light,
    //   surface: AppColors.accent,
    // ),

    primarySwatch: createMaterialColor(colorPrimary),
    hintColor: const Color.fromARGB(255, 162, 162, 162),
    primaryColor: const Color.fromRGBO(224, 124, 121, 1),
    secondaryHeaderColor: const Color.fromRGBO(13, 13, 13, 1),
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: Color.fromRGBO(224, 124, 121, 1)),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: const Color.fromRGBO(13, 13, 13, 1),
    dividerColor: viewLineColor,
    cardColor: const Color.fromRGBO(238, 238, 238, 1),
    tabBarTheme: const TabBarTheme(labelColor: Colors.black),
    appBarTheme: AppBarTheme(
      color: colorPrimary,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.backgroundLight),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
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
    primarySwatch: createMaterialColor(AppColors.primaryDark),
    primaryColor: const Color.fromRGBO(187, 134, 252, 1.0),
    scaffoldBackgroundColor: AppColors.buttonStroke,
    secondaryHeaderColor: Colors.white,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: AppColors.backgroundLight),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.black,
    // textTheme: TextTheme(),
    dividerColor: Colors.white12,
    cardColor: const Color.fromRGBO(44, 44, 44, 1),
    tabBarTheme: const TabBarTheme(labelColor: Color.fromARGB(255, 7, 48, 130)),
    appBarTheme: const AppBarTheme(
      color: scaffoldSecondaryDark,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.buttonStroke,
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
