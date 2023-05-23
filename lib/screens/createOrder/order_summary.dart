// ignore_for_file: unused_field

import 'dart:io';

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/Components/widgets/custom_textfield.dart';
import 'package:a2b/main.dart';
import 'package:a2b/screens/createOrder/order_map.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../controllers/order_details_text_controller.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'controller/create_order_controller.dart';

class OrderSummary extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OrderSummary({Key? key});

  @override
  State<OrderSummary> createState() => _OrderSummary();
}

class _OrderSummary extends State<OrderSummary> with TickerProviderStateMixin {
  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };

      return AppColors.errorDark;
    }

    final orderSummary = Get.put(PackageController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'order summary',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text('Product Name: '),
                  Text(orderSummary.package_name),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('${language.date}: '),
                  Text(
                    DateFormat('dd MMM yyyy')
                        .format(orderSummary.delivery_date),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('source: '),
                  Text(orderSummary.pickup_address),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('destination: '),
                  Text(orderSummary.delivery_address),
                ],
              ),
              CustomBtn(
                textonbtn: 'Confirm Order',
                onPress: () => orderSummary.addPackage(),
                primary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
