import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main/utils/allConstants.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(AppColors.primary),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: Colors.black),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    dividerColor: viewLineColor,
    cardColor: Colors.white,
    tabBarTheme: const TabBarTheme(labelColor: Colors.black),
    appBarTheme: const AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primary),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
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
    primarySwatch: createMaterialColor(AppColors.primary),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: const IconThemeData(color: Colors.white),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,
    tabBarTheme: const TabBarTheme(labelColor: Colors.white),
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
      primary: AppColors.primary,
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
}
