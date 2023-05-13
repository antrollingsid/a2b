


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final surname = TextEditingController();
  final phoneNo = TextEditingController();

}