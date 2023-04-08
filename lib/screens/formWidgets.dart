import 'package:a2b/screens/colors.dart';
import 'package:a2b/screens/fonts.dart';
import 'package:a2b/screens/loginPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: SizedBox(
        // height: 4,
        //USERNAME TEXTFIELD
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ),
            ),
            Container(
              width: 333,
              height: 62,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.secondary],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white, // set the color property to white
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.buttonDark,
                    // hintText: "Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: SizedBox(
        // height: 4,
        //USERNAME TextFieldEmail
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ),
            ),
            Container(
              width: 333,
              height: 62,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.secondary],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white, // set the color property to white
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.buttonDark,
                    // hintText: "Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: SizedBox(
        // height: 4,
        //USERNAME TEXTFIELD

        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ),
            ),
            Container(
              width: 333,
              height: 62,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.secondary],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white, // set the color property to white
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.buttonDark,
                    // hintText: "Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InkWellSignIn extends StatelessWidget {
  const InkWellSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 9),
        child: InkWell(
          onTap: () => const LoginPage(),
          child: RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                fontFamily: AppFonts.mainFont,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: AppColors.onBackgroundDark,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign In!',
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: AppColors.secondary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage() // SecondPage(),
                            )),
                  mouseCursor: MaterialStateMouseCursor.clickable,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InkWellSignUp extends StatelessWidget {
  const InkWellSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 9),
        child: InkWell(
          onTap: () => const LoginPage(),
          child: RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                fontFamily: AppFonts.mainFont,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: AppColors.onBackgroundDark,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up!',
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: AppColors.secondary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage() // SecondPage(),
                            )),
                  mouseCursor: MaterialStateMouseCursor.clickable,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
