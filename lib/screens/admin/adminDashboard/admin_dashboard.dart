import 'dart:async';
import 'package:a2b/main.dart';
import 'package:a2b/screens/admin/applications/application.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/auth_controller.dart';
import '../courierControl/courier_control.dart';
import '../orderControl/order_control.dart';
import '../userControl/user_control.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboard createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
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
                title: const Text('admin dash'),
              ),
              body: SafeArea(
                // on below line creating google maps
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const UserApplication());
                              },
                              child: Container(
                                color: context.primaryColor,
                                height: 100,
                                width: 170,
                                child: Text(
                                  'Applications',
                                  style: TextStyle(
                                      color: context.scaffoldBackgroundColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ManageGeneralUser());
                              },
                              child: Container(
                                color: context.primaryColor,
                                height: 100,
                                width: 170,
                                child: Text(
                                  'manage general users',
                                  style: TextStyle(
                                      color: context.scaffoldBackgroundColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ManageCouriers());
                              },
                              child: Container(
                                color: context.primaryColor,
                                height: 100,
                                width: 170,
                                child: Text(
                                  'manage couriers',
                                  style: TextStyle(
                                      color: context.scaffoldBackgroundColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ManageOrder());
                              },
                              child: Container(
                                color: context.primaryColor,
                                height: 100,
                                width: 170,
                                child: Text(
                                  'manage orders',
                                  style: TextStyle(
                                      color: context.scaffoldBackgroundColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
