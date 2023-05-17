// import 'package:a2b/main.dart';
// ignore_for_file: unused_import

import 'package:a2b/screens/profile.dart';
import '../app_theme.dart';
import '../main/languages/app_localizations.dart';
import '../main/languages/base_language.dart';
import '../../main.dart';
import '../../main/utils/allConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
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
  String selectedItem = 'en';

  String? selectedLanguage;
  String selectedItemColor = 'light';
  void init() async {
    currentIndex = getIntAsync(THEME_MODE_INDEX);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          "a2b",
          style: TextStyle(
            color: context.primaryColor,
            fontSize: 21,
            fontFamily: 'Material Icons',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: context.scaffoldBackgroundColor,
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
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 333,
                  child: Text(
                    "sign up and get start delivery your packages!",
                    style: TextStyle(
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
            const SizedBox(
              height: 250,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const Icon(LineIcons.sun),
                  onTap: () {
                    print('this is light modde');
                    appStore.setDarkMode(false);
                    print('we set light mode to true');
                    setValue(THEME_MODE_INDEX, 1);
                    setState(() {});
                    LiveStream().emit('UpdateTheme');
                    finish(context);
                  },
                ),
                InkWell(
                  child: const Icon(LineIcons.moon),
                  onTap: () {
                    print('this is dark modde');
                    appStore.setDarkMode(true);
                    print('we set dark mode to true');
                    setValue(THEME_MODE_INDEX, 2);
                    setState(() {});
                    LiveStream().emit('UpdateTheme');
                    finish(context);
                  },
                ),
              ],
            ),

            // .onTap(() async {
            //   currentIndex = index;
            //   if (index == appThemeMode.themeModeSystem) {
            //     appStore.setDarkMode(
            //         MediaQuery.of(context).platformBrightness ==
            //             Brightness.dark);
            //   } else if (index == appThemeMode.themeModeLight) {
            //     appStore.setDarkMode(false);
            //   } else if (index == appThemeMode.themeModeDark) {
            //     appStore.setDarkMode(true);
            //   }
            //   setValue(THEME_MODE_INDEX, index);
            //   setState(() {});
            //   LiveStream().emit('UpdateTheme');
            //   finish(context);
            // },

            // ChangeThemeButtonWidget(),
            // DropdownButton(
            //   value: selectedItemColor,
            //   items: const [
            //     DropdownMenuItem(value: 'light', child: Text('light')),
            //     DropdownMenuItem(value: 'dark', child: Text('dark')),
            //   ],
            //   onChanged: (value) {
            //     setState(() {
            //       try {
            //         if (value == 'dark') {
            //           appThemeMode.themeModeDark;
            //           appStore.setDarkMode(true);
            //           print('we set dark mode to true');
            //           setValue(THEME_MODE_INDEX, 2);
            //           setState(() {});
            //           LiveStream().emit('UpdateTheme');
            //           finish(context);
            //         } else if (value == 'light') {
            //           appThemeMode.themeModeLight;
            //           appStore.setDarkMode(false);
            //           setValue(THEME_MODE_INDEX, 1);
            //           print('we set light mode to true');
            //           setState(() {});
            //           LiveStream().emit('UpdateTheme');
            //           finish(context);
            //         }
            //       } catch (e) {
            //         print(e);
            //       }
            //       selectedItemColor = value!;
            //     });
            //   },
            // ),
            DropdownButton(
              value: selectedItem,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'tr', child: Text('Turkish')),
              ],
              onChanged: (value) {
                setState(() {
                  try {
                    setValue(SELECTED_LANGUAGE_CODE, value);
                    appStore.setLanguage(value!);
                    setState(() {});
                    LiveStream().emit('UpdateLanguage');
                    finish(context);
                  } catch (e) {
                    print(e);
                  }
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
// themeModeLight = 1;
// themeModeDark = 2;
//  themeModeSystem = 0;


