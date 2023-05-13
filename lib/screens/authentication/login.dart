import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/main/utils/colors.dart';
import 'package:a2b/screens/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/widgets/login_with_btn.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/inkwell_button.dart';
import '../../controllers/login_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final logcontroller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomLoginSignupAppBar(
          titleText: 'Log in',
        ),
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const LoginWithBtn(),
                CustomTextfield(
                  hintText: 'sample@a2b.com',
                  titleText: 'Email',
                  isPassword: false,
                  mycontroller: logcontroller.email
                ),
                CustomTextfield(
                  hintText: 'Enter your password',
                  isPassword: true,
                  titleText: 'Password',
                  mycontroller: logcontroller.password,
                ),
                Expanded(child: Container()),
                CustomBtn(
                  textonbtn: 'Login',
                  onPress: () => controller.signIn(
                      context, logcontroller.email.text, logcontroller.password.text),
                ),
                InkwellBtn(
                  textLeading: "Don't have an account?",
                  textEnding: ' signup',
                  onTap: () => Get.to(() => const Register()),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
