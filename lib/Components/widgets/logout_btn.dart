import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({super.key, required this.action});
  final String action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(0),
        width: 333,
        height: 52,
        decoration: BoxDecoration(
          color: appStore.isDarkMode
              ? AppColors.buttonDark
              : AppColors.buttonLight,
          borderRadius: BorderRadius.circular(5),
        ),
        // border: Border.all(color: context.primaryColor)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  action,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: appStore.isDarkMode
                        ? AppColors.errorDark
                        : AppColors.errorLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
