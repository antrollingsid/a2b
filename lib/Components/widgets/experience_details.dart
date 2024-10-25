import 'package:flutter/material.dart';

import '../../main.dart';
import '../../main/utils/allConstants.dart';
import '../assets/fonts.dart';

class ExperienceDetails extends StatelessWidget {
  const ExperienceDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: 333,
      decoration: BoxDecoration(
        color:
            appStore.isDarkMode ? AppColors.buttonDark : AppColors.buttonLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "6",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Experiences",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 54,
            child: VerticalDivider(
              color: AppColors.textGrey,
              thickness: 1,
              width: 20,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "6",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Experiences",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 54,
            child: VerticalDivider(
              color: AppColors.textGrey,
              thickness: 1,
              width: 20,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "6",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Experiences",
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
