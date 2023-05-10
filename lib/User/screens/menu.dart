// ignore: file_names
import 'package:a2b/User/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/widgets/custom_calendar.dart';
import '../../Components/widgets/settings_button.dart';
import '../../main.dart';
import '../../main/chat/chat_screen.dart';
import '../../main/utils/allConstants.dart';
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

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
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
                child: SettingBtn(action: 'messages'),
                onTap: () => Get.to(ChatScreen()),
              ),
              GestureDetector(
                child: SettingBtn(action: 'home'),
                onTap: () => Get.to(DashBoard()),
              ),
              SettingBtn(action: 'offers'),
              SettingBtn(action: 'order history'),
              SettingBtn(action: 'create an order'),

              // CustomShip(),
            ],
          ),
        ),
      ),
    );
  }
}
