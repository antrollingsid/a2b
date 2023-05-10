// ignore: file_names
import 'package:flutter/material.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

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
            children: const [
              // CustomCalendar(),
              // CustomShip(),
            ],
          ),
        ),
      ),
    );
  }
}
