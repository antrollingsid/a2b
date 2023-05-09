import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

Widget commonButton(String title, Function() onTap,
    {double? width, Color? color, Color? textColor}) {
  return SizedBox(
    width: width,
    child: AppButton(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius)),
      elevation: 0,
      color: color ?? colorPrimary,
      onTap: onTap,
      child: Text(
        title,
        style: boldTextStyle(color: textColor ?? white),
      ),
    ),
  );
}

Widget outlineButton(String title, Function() onTap, {double? width}) {
  return SizedBox(
    width: width,
    child: TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
            side: BorderSide(color: borderColor)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: Colors.transparent,
      ),
      child: Text(
        title,
        style: boldTextStyle(),
      ),
    ),
  );
}

Widget scheduleOptionWidget(
    BuildContext context, bool isSelected, String imagePath, String title) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: boxDecorationWithRoundedCorners(
        border: Border.all(
            color: isSelected
                ? colorPrimary
                : appStore.isDarkMode
                    ? Colors.transparent
                    : borderColor),
        backgroundColor: context.cardColor),
    child: Row(
      children: [
        ImageIcon(AssetImage(imagePath),
            size: 20, color: isSelected ? colorPrimary : Colors.grey),
        16.width,
        Text(title, style: boldTextStyle()).expand(),
      ],
    ),
  );
}
