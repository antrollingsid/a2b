// ignore: file_names
// ignore_for_file: dead_code

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../screens/profile/profile.dart';
import '../assets/fonts.dart';

// ignore: camel_case_types
class backBtn extends StatelessWidget {
  const backBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: IconButton(
        icon: SvgPicture.string(
          SvgConstant.backArrow,
          color: AppColors.onBackgroundDark,
        ),
        onPressed: () {
          // Wrap the navigation code inside a try-catch block
          try {
            // Check if the current route can be popped
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } catch (e) {
            print('Error navigating back: $e');
          }
        },
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
      color: Colors.transparent,
      child: IconButton(
        icon: SvgPicture.string(
          SvgConstant.profIcon,
          color: appStore.isDarkMode
              ? AppColors.onBackgroundDark
              : AppColors.onBackgroundLight,
        ),
        onPressed: () {
          Get.to(const Profile());
        },
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
                color: appStore.isDarkMode
                    ? AppColors.onBackgroundDark
                    : AppColors.onBackgroundLight,
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
      backgroundColor: AppColors.backgroundLight,
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.titleText,
      required this.isActionVisible,
      required this.isLeadingVisible});
  final String titleText;
  final bool isActionVisible;
  final bool isLeadingVisible;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: isLeadingVisible
          ? const Padding(
              padding: EdgeInsets.fromLTRB(27, 4, 0, 4),
              child: backBtn(),
            )
          : Container(),
      leadingWidth: 74,
      title: Text(
        titleText,
        style: TextStyle(
          fontFamily: AppFonts.mainFont,
          fontSize: 15,
          color: appStore.isDarkMode
              ? AppColors.onBackgroundDark
              : AppColors.onBackgroundLight,
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
      backgroundColor: Colors.transparent,
    );
  }
}

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.titleText,
  });
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(27, 4, 0, 4),
          child: backBtn(),
        ),
        leadingWidth: 74,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 10,
              width: double.infinity,
              // margin: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontFamily: AppFonts.mainFont,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.onBackgroundDark,
          ),
        ),
        actions: true
            ? [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 30, 3),
                  child: menuBtn(),
                ),
              ]
            : [], // empty list to hide the action button
        elevation: 0,
        backgroundColor:
            Colors.transparent, // set background color to transparent
      ),
    );
  }
}

class ProfileAppbar extends StatelessWidget {
  ProfileAppbar({
    super.key,
    required this.titleText,
    required this.isActionVisible,
  });
  final String titleText;
  final bool isActionVisible;
  String selectedItem = 'en';

  String? selectedLanguage;
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
          fontSize: 15,
          color: appStore.isDarkMode
              ? AppColors.onBackgroundDark
              : AppColors.onBackgroundLight,
        ),
      ),
      actions: isActionVisible
          ? [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 30, 3),
                child: lngBtn(),
              ),
            ]
          : [], // empty list to hide the action button
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  lngBtn() {}
}
