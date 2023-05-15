import 'package:flutter/material.dart';
import '../../main/utils/colors.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav(
      {super.key,
      required this.actionitem1,
      required this.actionitem2,
      required this.actionitem3,
      required this.actionitem4,
      required this.actionitem5});
  final GestureTapCallback actionitem1;
  final GestureTapCallback actionitem2;
  final GestureTapCallback actionitem3;
  final GestureTapCallback actionitem4;
  final GestureTapCallback actionitem5;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.buttonStroke,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'hhh',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        AppColors.secondaryBlue,
                        AppColors.primary,
                      ],
                      begin: FractionalOffset(0.0, 1.0),
                      end: FractionalOffset(1.0, 0.4),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.add,
                color: AppColors.background,
                size: 40,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: AppColors.backgroundLightMode,
            ),
            label: '',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) {
          if (index == 0) {
            actionitem1;
          } else if (index == 1) {
            actionitem2;
          } else if (index == 2) {
            actionitem3;
          } else if (index == 3) {
            actionitem4;
          } else if (index == 4) {
            actionitem5;
          }
        },
      ),
    );
  }
}
