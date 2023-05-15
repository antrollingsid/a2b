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
import '../../controllers/login_text_controller.dart';
import '../../main.dart';

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
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child:
              CustomAppBar(titleText: language.signIn, isActionVisible: false)),
      body: GetBuilder<AuthController>(builder: (controller) {
        return SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Glad to see you again!",
                style: TextStyle(
                    wordSpacing: 5,
                    fontFamily: 'Material Icons',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 333,
                child: Text(
                  "sign it and continue to delivery your\npackages!",
                  style: TextStyle(
                      fontFamily: 'Material Icons',
                      color: AppColors.textFaded,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              const LoginWithBtn(),
              CustomTextfield(
                hintText: 'sample@a2b.com',
                isPassword: false,
                mycontroller: logcontroller.email,
                width: 333,
              ),
              CustomTextfield(
                hintText: 'Enter your password',
                isPassword: true,
                mycontroller: logcontroller.password,
                width: 333,
              ),
              const SizedBox(
                height: 50,
              ),
              // Expanded(child: Container()),
              CustomBtn(
                textonbtn: 'Login',
                onPress: () => controller.signIn(context,
                    logcontroller.email.text, logcontroller.password.text),
                primary: true,
              ),
              const SizedBox(
                height: 20,
              ),
              InkwellBtn(
                textLeading: "Don't have an account?",
                textEnding: ' Sign Up',
                onTap: () => Get.to(() => const Register()),
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        );
      }),
    );
  }
}
