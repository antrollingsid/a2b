import 'package:a2b/allConstants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../allConstants/dimensions.dart';
import '../assets/colors.dart';
import '../assets/fonts.dart';

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

class menuBtn extends StatelessWidget {
  const menuBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: Container(
        height: 54,
        width: 54,
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
              // Navigator.pop(context);
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
      // toolbarHeight: 100,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
      ]),
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
