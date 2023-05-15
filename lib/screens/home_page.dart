// import 'package:a2b/main.dart';
// ignore_for_file: unused_import

import 'package:a2b/screens/profile.dart';

import '../../main.dart';
import '../../main/utils/allConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main/utils/colors.dart';
import '../../Components/widgets/custom_button.dart';
import '../../Components/widgets/inkwell_button.dart';
import 'authentication/login.dart';
import 'authentication/register.dart';

final List<String> imgList = [
  'assets/images/1x/Artboard14.png',
  'assets/images/1x/Artboard14.png',
  'assets/images/1x/Artboard14.png',
];
int currentIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedItem = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: const Text(
          "a2b",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 21,
            fontFamily: 'Material Icons',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 160,
            ),
            Column(
              children: const [
                Text(
                  "Welcome to a2b delivery!",
                  style: TextStyle(
                      wordSpacing: 5,
                      fontFamily: 'Material Icons',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 333,
                  child: Text(
                    "sign up and get start delivery your packages!",
                    style: TextStyle(
                        fontFamily: 'Material Icons',
                        color: AppColors.textFaded,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomBtn(
              textonbtn: language.signIn,
              onPress: () => Get.to(const LoginPage()),
              primary: true,
            ),
            CustomBtn(
              textonbtn: language.signUp,
              onPress: () => Get.to(const Register()),
              primary: false,
            ),
            // InkwellBtn(
            //   textLeading: 'Already have an account ?  ',
            //   textEnding: language.signIn,
            //   onTap: () => Get.to(const LoginPage()),
            // ),
            const SizedBox(
              height: 230,
            ),
            DropdownButton(
              value: selectedItem,
              items: const [
                DropdownMenuItem(value: 'Item 1', child: Text('English')),
                DropdownMenuItem(value: 'Item 2', child: Text('Turkish')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedItem = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
