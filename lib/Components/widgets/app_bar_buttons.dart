// ignore: file_names
import 'package:a2b/screens/menu.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

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
      child: IconButton(
        icon: SvgPicture.string(SvgConstant.backArrow,
            color: context.primaryColor),
        onPressed: () {
          Navigator.pop(context);
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
          SvgConstant.burgerMenuDark,
          color: context.primaryColor,
        ),
        onPressed: () {
          Get.to(const MenuPage());
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
      backgroundColor: AppColors.backgroundLightMode,
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
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: context.primaryColor,
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
      backgroundColor: context.scaffoldBackgroundColor,
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/1x/1.png'),
          colorFilter: ColorFilter.mode(
            AppColors.backgroundLightMode.withOpacity(0.6),
            BlendMode.multiply,
          ),
          fit: BoxFit.cover,
        ),
      ),
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
              decoration: const BoxDecoration(
                color: AppColors.backgroundLightMode,
                borderRadius: BorderRadius.only(
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
