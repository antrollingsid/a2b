import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationTextController extends GetxController {
  static LocationTextController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final from = TextEditingController();
  final to = TextEditingController();
  final name = TextEditingController();
  final number = TextEditingController();
}
