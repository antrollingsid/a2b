import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/widgets/login_with_btn.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/inkwell_button.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
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
              CustomTextfield(
                hintText: 'Sid alfaouri',
                titleText: 'Name',
                isPassword: false,
                mycontroller: _namecontroller,
              ),
              CustomTextfield(
                hintText: 'sample@a2b.com',
                titleText: 'Email',
                isPassword: false,
                mycontroller: _emailcontroller,
              ),
              CustomTextfield(
                hintText: 'Pick a strong password',
                isPassword: true,
                titleText: 'Password',
                mycontroller: _passcontroller,
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
