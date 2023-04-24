import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'User/screens/authentication/login.dart';
import 'User/screens/authentication/register.dart';
import 'User/screens/homepage.dart';
import 'User/screens/trackpage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/loginpage', page: () => const LoginPage()),
        GetPage(name: '/registerpage', page: () => const Register()),
        GetPage(name: "/trackingpage", page: () => const TrackShippement()),
      ],
    );
  }
}
