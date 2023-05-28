// ignore_for_file: unused_field

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
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
    String selectedItem = 'en';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'order summary',
          isActionVisible: true,
          isLeadingVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 333,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${language.product}: ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(orderSummary.package_name),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.createdAt,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format(orderSummary.delivery_date),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.pickupLocation,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(orderSummary.pickup_address),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.deliveryLocation,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(orderSummary.delivery_address),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.paymentType,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    DropdownButton(
                      value: selectedItem,
                      items: [
                        DropdownMenuItem(
                            value: 'en', child: Text(language.cash)),
                        DropdownMenuItem(
                            value: 'tr', child: Text(language.creditCard)),
                      ],
                      onChanged: (value) {
                        setState(() {
                          try {
                            setValue(SELECTED_LANGUAGE_CODE, value);
                            appStore.setLanguage(value!);
                            setState(() {});
                            LiveStream().emit('UpdateLanguage');
                            finish(context);
                          } catch (e) {
                            print(e);
                          }
                          selectedItem = value!;
                        });
                      },
                    ),
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
      ),
    );
  }
}
