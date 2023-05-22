import 'dart:async';
import 'package:a2b/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/auth_controller.dart';

class UserApplication extends StatefulWidget {
  const UserApplication({Key? key}) : super(key: key);

  @override
  _UserApplication createState() => _UserApplication();
}

class _UserApplication extends State<UserApplication> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      if (controller.user.role == 'admin') {
        print('welcome admin');
      } else {
        print('you are not admin');
      }
      return controller.user.role == 'admin'
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF0F9D58),
                // on below line we have given title of app
                title: const Text('application'),
              ),
              body: SafeArea(
                // on below line creating google maps
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: context.primaryColor,
                          height: 100,
                          width: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: context.primaryColor,
                          height: 100,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('you have no access'),
              ],
            );
    });
  }
}
