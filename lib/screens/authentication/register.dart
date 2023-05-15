import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/widgets/login_with_btn.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../Components/widgets/custom_textfield.dart';
import '../../../Components/widgets/inkwell_button.dart';
import '../../controllers/signup_controller.dart';
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
        var Authcontroller = Get.put( AuthController());
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomLoginSignupAppBar(
          titleText: 'Sign up',
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          var isLoading= Authcontroller.isLoaddIn;
          return Stack(
            children: [
              CustomScrollView(slivers: [
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
                              titleText: 'Name',
                              isPassword: false,
                              mycontroller: regcontroller.name,
                            ),
                            CustomTextfield(
                              hintText: 'Alfaouri',
                              titleText: 'Surname',
                              isPassword: false,
                              mycontroller: regcontroller.surname,
                            ),
                            CustomTextfield(
                              hintText: 'sample@a2b.com',
                              titleText: 'Email',
                              isPassword: false,
                              mycontroller: regcontroller.email,
                            ),
                            CustomTextfield(
                                hintText: 'Pick a strong password',
                                isPassword: true,
                                titleText: 'Password',
                                mycontroller: regcontroller.password),
                            Expanded(child: Container()),
                            CustomBtn(
                                textonbtn: 'Register',
                                onPress: () => controller.register(
                                    context,
                                    regcontroller.email.text,
                                    regcontroller.password.text,
                                    regcontroller.name.text,
                                    regcontroller.password.text)),
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
              ]),

               // Loading overlay
    if (isLoading)
      Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
            ],
          );
        },
      ),
    );
  }
}
