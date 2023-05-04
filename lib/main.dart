import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'User/screens/authentication/login.dart';
import 'User/screens/authentication/register.dart';
import 'User/screens/splash_screen.dart';
import 'User/screens/dashboard.dart';
import 'main/languages/base_language.dart';
import 'main/store/store.dart';

AppStore appStore = AppStore();
late BaseLanguage language;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await AppStore();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
