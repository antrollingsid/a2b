// import 'package:a2b/main.dart';
// ignore_for_file: unused_import

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

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
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
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: 250,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        items: imgList
                            .map((item) => Center(
                                  child: SizedBox(
                                    width: 2500,
                                    child: Image.asset(item),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DotsIndicator(
                        dotsCount: imgList.length,
                        position: currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          color: AppColors.secondary,
                          size: const Size.square(5.0),
                          activeSize: const Size(30.0, 5.0),
                          activeColor: AppColors.primaryDark,
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  ),
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
                    width: 333,
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
                textEnding: 'language.logIn',
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
