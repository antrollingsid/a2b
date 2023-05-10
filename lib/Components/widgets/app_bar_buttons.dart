// ignore: file_names
import 'package:a2b/screens/menu.dart';
import 'package:get/get.dart';

import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../assets/fonts.dart';

// ignore: camel_case_types
class backBtn extends StatelessWidget {
  const backBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: Container(
        height: 47,
        width: 47,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.buttonStroke,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: SvgPicture.string(SvgConstant.backArrowDark),
          color: AppColors.onBackgroundDark,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class menuBtn extends StatelessWidget {
  const menuBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColors.backgroundDark,
      child: Container(
        height: 47,
        width: 47,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.buttonStroke,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            icon: SvgPicture.string(
              SvgConstant.burgerMenuDark,
            ),
            color: AppColors.onBackgroundDark,
            onPressed: () {
              Get.to(const MenuPage());
            },
          ),
        ),
      ),
    );
  }
}

class CustomLoginSignupAppBar extends StatelessWidget {
  const CustomLoginSignupAppBar({
    super.key,
    required this.titleText,
  });
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 14),
            child: backBtn(),
          ),
          const SizedBox(
            width: 12,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: Text(
              titleText,
              style: TextStyle(
                fontFamily: AppFonts.mainFont,
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackgroundDark,
              ),
            ),
          ),
        ],
      ),
      // actions: const [
      //   Padding(
      //     padding: EdgeInsets.only(right: 30),
      //     child: menuBtn(),
      //   ),
      // ],
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.titleText,
    required this.isActionVisible,
  });
  final String titleText;
  final bool isActionVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: const Padding(
        padding: EdgeInsets.fromLTRB(27, 4, 0, 4),
        child: backBtn(),
      ),
      leadingWidth: 74,
      title: Text(
        titleText,
        style: TextStyle(
          fontFamily: AppFonts.mainFont,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.onBackgroundDark,
        ),
      ),
      actions: isActionVisible
          ? [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 30, 3),
                child: menuBtn(),
              ),
            ]
          : [], // empty list to hide the action button
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
    );
  }
}
