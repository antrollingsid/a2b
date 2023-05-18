import 'package:a2b/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/login_with_btn.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/inkwell_button.dart';
import '../../controllers/signup_text_controller.dart';
import '../../main.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final regcontroller = Get.put(SignUpController());
    var Authcontroller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child:
              CustomAppBar(titleText: language.signUp, isActionVisible: false)),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return CustomScrollView(slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const LoginWithBtn(),
                        CustomTextfield(
                          hintText: 'Sid',
                          isPassword: false,
                          mycontroller: regcontroller.name,
                          width: 333,
                        ),
                        CustomTextfield(
                          hintText: 'Alfaouri',
                          isPassword: false,
                          mycontroller: regcontroller.surname,
                          width: 333,
                        ),
                        CustomTextfield(
                          hintText: 'sample@a2b.com',
                          isPassword: false,
                          mycontroller: regcontroller.email,
                          width: 333,
                        ),
                        CustomTextfield(
                          hintText: 'Pick a strong password',
                          isPassword: true,
                          mycontroller: regcontroller.password,
                          width: 333,
                        ),
                        Expanded(child: Container()),
                        CustomBtn(
                          textonbtn: 'Register',
                          onPress: () => controller.register(
                              context,
                              regcontroller.email.text,
                              regcontroller.password.text,
                              regcontroller.name.text,
                              regcontroller.password.text),
                          primary: true,
                        ),
                          textonbtn: 'Register',
                          onPress: () => controller.register(
                              context,
                              regcontroller.email.text,
                              regcontroller.password.text,
                              regcontroller.name.text,
                              regcontroller.password.text),
                          primary: true,
                        ),
                        InkwellBtn(
                          textLeading: 'Already have an account ?  ',
                          textEnding: 'login',
                          onTap: () => Get.to(() => const LoginPage()),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ))
          ]);
        },
      ),
    );
  }
}
