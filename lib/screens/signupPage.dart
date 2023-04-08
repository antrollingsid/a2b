// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers

import 'package:a2b/screens/buttons.dart';
import 'package:a2b/screens/colors.dart';
import 'package:a2b/screens/fonts.dart';
import 'package:flutter/material.dart';
import 'formWidgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.buttonStroke,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: IconButton(
                  // iconSize: ,
                  padding: const EdgeInsets.fromLTRB(7, 3, 0, 3),
                  icon: Icon(Icons.adaptive.arrow_back, size: 18.0),
                  color: AppColors.onBackgroundDark,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: AppFonts.mainFont,
                fontSize: 33,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackgroundDark,
              ),
            ),
          ],
        ),
      ),
      body: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: AppColors.backgroundDark,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
              // height: 90,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(0, 220, 227, 217),
                  width: 3.0,
                ),
                color: const Color.fromARGB(0, 168, 2, 165),
              ),
            ), //first transparent container
            Container(
              padding: const EdgeInsets.fromLTRB(19, 0, 15, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up with one of the following options.",
                  style: TextStyle(
                    color: AppColors.onBackgroundDark,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    color: AppColors.buttonDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: InkWell(
                      onTap: () {},
                      // splashColor: Colors.red,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                              color: AppColors.buttonStroke, width: 2.5),
                        ),
                        child: Image.asset(
                          'assets/images/icons/google.png',
                          // fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    color: AppColors.buttonDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: InkWell(
                      onTap: () {},
                      // splashColor: Colors.red,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: (MediaQuery.of(context).size.width - 60) / 2,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                              color: AppColors.buttonStroke, width: 2.5),
                        ),
                        child: Image.asset(
                          'assets/images/icons/apple.png',
                          // fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextFieldName(),
                  TextFieldEmail(),
                  TextFieldPassword(),
                  SignUpButton(),
                  InkWellSignIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
