import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
          margin: EdgeInsets.all(0),
          width: 333,
          height: 86,
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Apply for couriership",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      // height:  1.5*ffem/fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Text(
                    "This subscription is auto-renewalble",
                    style: TextStyle(
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
