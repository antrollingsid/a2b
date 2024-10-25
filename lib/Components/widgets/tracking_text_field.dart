import 'package:a2b/main/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../main/utils/allConstants.dart';

class TrackingTextField extends StatelessWidget {
  const TrackingTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: Center(
          child: TextField(
            style: const TextStyle(color: AppColors.backgroundLight),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.string(
                  SvgConstant.searchIconDark,
                  width: 19,
                  height: 19,
                ),
              ),
              hintText: 'Tracking code',
              hintStyle: const TextStyle(color: AppColors.textGrey),
              filled: true,
              fillColor: appStore.isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(
                    colors: [AppColors.secondaryDark, AppColors.primaryLight],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                width: 1,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
