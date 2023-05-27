import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/screens/profile/applyForCourier/apply_for_courier.dart';
import 'package:a2b/screens/profile/editProfile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/settings_button.dart';
import '../../../Components/widgets/sign_out_btn.dart';
import 'info/top_profile.dart';
import '../../../Components/widgets/upgrade_button.dart';
import '../../../main.dart';
import '../pick_language.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedItem = 'en';

  String? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: context.primaryColor),
        ),
        leading: backBtn(),
        actions: [
          Row(
            children: [
              IconButton(
                icon: appStore.isDarkMode
                    ? const Icon(LineIcons.sun)
                    : Icon(LineIcons.moon, color: context.primaryColor),
                onPressed: () {
                  print('Toggle Theme Mode');
                  appStore.setDarkMode(!appStore.isDarkMode);
                  setValue(THEME_MODE_INDEX, appStore.isDarkMode ? 2 : 1);
                  setState(() {});
                  LiveStream().emit('UpdateTheme');
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = 'en';
                  });
                  _updateLanguage('en');
                },
                child: Text(
                  'EN',
                  style: TextStyle(
                    color: selectedItem == 'en'
                        ? context.primaryColor
                        : context.hintColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = 'tr';
                  });
                  _updateLanguage('tr');
                },
                child: Text(
                  'TR',
                  style: TextStyle(
                    color: selectedItem == 'tr'
                        ? context.primaryColor
                        : context.hintColor,
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // if()
                const TopProfile(),
                InkWell(
                  child: SettingBtn(action: language.editProfile),
                  onTap: () => Get.to(() => const EditProfile()),
                ),

                InkWell(
                    onTap: () => Get.to(() => const ApplyForCourier()),
                    child: SettingBtn(action: 'apply for couriership')),

                SizedBox(
                  height: 180,
                ),
                InkWell(
                    onTap: () => Get.find<AuthController>().signOut(),
                    child: SettingBtn(action: language.logout))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateLanguage(String languageCode) {
    try {
      setValue(SELECTED_LANGUAGE_CODE, languageCode);
      appStore.setLanguage(languageCode);
      setState(() {});
      LiveStream().emit('UpdateLanguage');
      // Navigator.pushReplacementNamed(context, '/profile');
    } catch (e) {
      print(e);
    }
    setState(() {
      selectedItem = languageCode;
    });
  }
}
