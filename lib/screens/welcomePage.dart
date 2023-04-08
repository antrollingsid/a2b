// ignore_for_file: unused_import, duplicate_import, file_names

import 'package:a2b/screens/buttons.dart';
import 'package:a2b/screens/fonts.dart';
import 'package:a2b/screens/formWidgets.dart';
import 'package:a2b/screens/signupPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:a2b/screens/colors.dart';
import 'package:a2b/screens/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'loginPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: AppColors.onBackgroundDark,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Container>[
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Image.asset('assets/images/1x/Artboard14.png'),
              ),

              //PROFESSIONAL SERVICE TEXT
              Container(
                padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                child: Text(
                  'Professional Service',
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 35.0,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Text(
                  'courier services!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ),

              //BUTTON
              Container(
                padding: const EdgeInsets.only(top: 99),
                child: const CreateAccountButton(),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0),
                child: const InkWellSignIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
