import 'package:flutter/material.dart';

import '../../main/utils/colors.dart';
import '../../main/utils/dimensions.dart';

class UpgadeBtn extends StatelessWidget {
  const UpgadeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(0),
          width: 333,
          height: 86,
          decoration: BoxDecoration(
            color: AppColors.buttonDark,
            borderRadius: BorderRadius.circular(
              Dimensions.borderRadius8,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: 38,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.buttonRed,
                      borderRadius: BorderRadius.circular(
                        Dimensions.borderRadius8,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Pro",
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          // height:  1.5*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      // height:  1.5*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                  const Text(
                    "This subscription is auto-renewalble",
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      // height:  1.5*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
