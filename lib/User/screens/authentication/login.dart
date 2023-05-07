import 'package:a2b/main/utils/colors.dart';
import 'package:a2b/User/screens/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/widgets/login_with_btn.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/inkwell_button.dart';
import '../dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomLoginSignupAppBar(
          titleText: 'Log in',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const LoginWithBtn(),
              const CustomTextfield(
                hintText: 'sample@a2b.com',
                titleText: 'Email',
                isPassword: false,
              ),
              const CustomTextfield(
                hintText: 'Enter your password',
                isPassword: true,
                titleText: 'Password',
              ),
              Expanded(child: Container()),
              CustomBtn(
                textonbtn: 'Login',
                onPress: () => Get.to(const DashBoard()),
              ),
              InkwellBtn(
                textLeading: "Don't have an account?",
                textEnding: ' signup',
                onTap: () => Get.to(const Register()),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
