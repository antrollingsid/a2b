import 'package:a2b/Components/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/login_with_btn.dart';
import '../../../Components/widgets/appBar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/custom_textfield_gradiant.dart';
import '../../../Components/widgets/inkwell_button.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomLoginSignupAppBar(
          titleText: 'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              const LoginWithBtn(),
              const GradiantTextfield(
                hintText: 'Sid alfaouri',
                titleText: 'Name',
              ),
              const GradiantTextfield(
                hintText: 'sample@a2b.com',
                titleText: 'Email',
              ),
              const CustomTextfield(
                hintText: 'Pick a strong password',
                isPassword: true,
                titleText: 'Password',
              ),
              Expanded(child: Container()),
              CustomBtn(textonbtn: 'Register', onPress: () => () {}),
              InkwellBtn(
                textLeading: 'Already have an account ?  ',
                textEnding: 'login',
                onTap: () => Get.to(const LoginPage()),
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
