import 'package:flutter/material.dart';

import '../../main/utils/colors.dart';
import '../../main/utils/dimensions.dart';

class SignOutBtn extends StatelessWidget {
  const SignOutBtn({super.key});

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
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign Out",
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    // height:  1.5*ffem/fem,
                    color: AppColors.errorDark),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
