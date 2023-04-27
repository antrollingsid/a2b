import 'package:a2b/allConstants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Components/widgets/custom_button.dart';
import '../../Components/widgets/inkwell_button.dart';
import 'authentication/login.dart';
import 'authentication/register.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: SvgPicture.string(SvgConstant.splashSvgDark1),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                  child: Column(
                children: const [
                  Text(
                    "Professional Service",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      "Ship and track parcels and packages and learn about our express courier services.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  )
                ],
              )),
              CustomBtn(
                textonbtn: 'Create an account',
                onPress: () => Get.to(const Register()),
              ),
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
