

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffertController extends GetxController {

  static OffertController get instance => Get.find();


  //TextField Controllers to get data from TextFields
  final price = TextEditingController();
  final time = TextEditingController();


}