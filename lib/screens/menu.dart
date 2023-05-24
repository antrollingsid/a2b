// ignore: file_names
import 'package:a2b/screens/userDetails/courierList/courier-list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/settings_button.dart';
import '../screens/chat/chat_screen.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'dashboard.dart';

class MenuPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MenuPage({Key? key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Menu',
          isActionVisible: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomCalendar(),
              GestureDetector(
                child: const SettingBtn(action: 'messages'),
                onTap: () => Get.to(const ChatScreen()),
              ),
              GestureDetector(
                child: const SettingBtn(action: 'home'),
                onTap: () => Get.to(() => const DashBoard()),
              ),
              const SettingBtn(action: 'offers'),
              const SettingBtn(action: 'order history'),
              const SettingBtn(action: 'create an order'),
              GestureDetector(
                child: const SettingBtn(action: 'Couriers'),
                onTap: () => Get.to(() => const CourierList()),
              ),

              // CustomShip(),
            ],
          ),
        ),
      ),
    );
  }
}
