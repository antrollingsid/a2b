import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main/utils/allConstants.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(AppColors.primaryDark),
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: IconThemeData(color: Colors.black),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    dividerColor: viewLineColor,
    cardColor: Colors.white,
    tabBarTheme: TabBarTheme(labelColor: Colors.black),
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primaryDark),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryDark,
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(AppColors.primaryDark),
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.roboto().fontFamily,
    iconTheme: IconThemeData(color: Colors.white),
    dialogBackgroundColor: scaffoldSecondaryDark,
    unselectedWidgetColor: Colors.white60,
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,
    tabBarTheme: TabBarTheme(labelColor: Colors.white),
    appBarTheme: AppBarTheme(
      color: scaffoldSecondaryDark,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: scaffoldSecondaryDark,
      ),
    ),
    dialogTheme: DialogTheme(shape: dialogShape()),
    snackBarTheme: SnackBarThemeData(backgroundColor: appButtonColorDark),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: appButtonColorDark),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
