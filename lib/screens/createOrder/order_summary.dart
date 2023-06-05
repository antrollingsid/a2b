// ignore_for_file: unused_field

import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:a2b/main.dart';
import 'package:a2b/screens/qr_genartor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

   // In this example, suppose that all messages contain a data field with the key 'type'.
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat',
        arguments: ChatArguments(),
      );
    }
  }
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
                QRCodeGenerator(
                  courrierid: orderSummary.courrier_id,
                  deliverydate: orderSummary.delivery_date,
                  packagename: orderSummary.package_name,
                  packagetype: orderSummary.package_type,
                  packageweight: orderSummary.package_weight,
                  pickupaddress: orderSummary.pickup_address,
                  senderid: orderSummary.sender_id,
                ),
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

class ChatArguments {
  
}
