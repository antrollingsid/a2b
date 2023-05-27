import 'package:a2b/main.dart';
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
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                language.logout,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: context.primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
