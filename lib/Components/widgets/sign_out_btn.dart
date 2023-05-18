import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


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
          height: 52,
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign Out",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    // height:  1.5*ffem/fem,
                    color: context.scaffoldBackgroundColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
