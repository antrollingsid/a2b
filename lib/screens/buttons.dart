import 'package:a2b/screens/dashboard.dart';
import 'package:a2b/screens/colors.dart';
import 'package:a2b/screens/fonts.dart';
import 'package:a2b/screens/loginPage.dart';
import 'package:a2b/screens/signupPage.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      height: 67,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                AppColors.primaryDark,
              ],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(1.0, 0.4),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(22),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SignUpPage() // SecondPage(),
                ),
          ),
          child: Text(
            'Create An Account',
            style: TextStyle(
              fontFamily: AppFonts.mainFont,
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              color: AppColors.backgroundDark,
            ),
          ),
        ),
      ),
    );
  }
}

//SIGNUP BUTTON
class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 78.0),
        child: SizedBox(
          width: 333,
          height: 67,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: LinearGradient(
                  colors: [
                    AppColors.secondary,
                    AppColors.primaryDark,
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(1.0, 0.4),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(22),
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage() // SecondPage(),
                    ),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                  color: AppColors.backgroundDark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//LOGIN BUTTON
class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 98.0),
        child: SizedBox(
          width: 350,
          height: 67,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: LinearGradient(
                  colors: [
                    AppColors.secondaryBlue,
                    AppColors.primaryDark,
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(1.0, 0.4),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(22),
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardPage() // SecondPage(),
                    ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                  color: AppColors.backgroundDark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
