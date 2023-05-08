// ignore: file_names
import 'package:flutter/material.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class EmptyPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const EmptyPage({Key? key});

  @override
  State<EmptyPage> createState() => _EmptyPage();
}

class _EmptyPage extends State<EmptyPage> {
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
          titleText: 'Empty Pagge',
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.buttonStroke,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryDark,
        onTap: (index) {
          if (index == 2) {
            // Get.to(() => const EmptyPage());
          }
        },
      ),
    );
  }
}
