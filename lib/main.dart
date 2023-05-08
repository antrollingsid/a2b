import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'User/screens/authentication/login.dart';
import 'User/screens/authentication/register.dart';
import 'User/screens/splash_screen.dart';
import 'User/screens/dashboard.dart';
import 'main/languages/base_language.dart';
import 'main/store/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppStore appStore = AppStore();
late BaseLanguage language;

void main() async {
  AppStore();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      //  localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', 'US'), // Set a default locale

      debugShowCheckedModeBanner: false,
      home: const SplashScreenPage(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreenPage()),
        GetPage(name: '/loginpage', page: () => const LoginPage()),
        GetPage(name: '/registerpage', page: () => const Register()),
        GetPage(name: "/trackingpage", page: () => const DashBoard()),
      ],
    );
  }
}
