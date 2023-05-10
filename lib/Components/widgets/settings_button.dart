import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main/utils/colors.dart';
import '../../main/utils/dimensions.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn({super.key, required this.action});
  final String action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(0),
          width: 333,
          height: 67,
          decoration: BoxDecoration(
            color: AppColors.buttonDark,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadius8,
            ),
          ),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  action,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    // height:  1.5*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(child: SvgPicture.string(SvgConstant.arrowRight)),
            )
          ]),
        ),
      ),
    );
  }
}
