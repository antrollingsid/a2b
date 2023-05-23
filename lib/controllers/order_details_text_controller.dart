import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetails extends GetxController {
  static OrderDetails get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final productName = TextEditingController();
  final description = TextEditingController();
}
