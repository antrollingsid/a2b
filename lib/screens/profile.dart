import 'package:a2b/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/settings_button.dart';
import '../../Components/widgets/sign_out_btn.dart';
import '../../Components/widgets/top_profile.dart';
import '../../Components/widgets/upgrade_button.dart';
import '../../main.dart';
import '../../main/utils/colors.dart';
import 'pick_language.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Profile',
          isActionVisible: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopProfile(),
              SettingBtn(action: language.editProfile),
              const SettingBtn(action: 'Settings'),
              SettingBtn(action: language.wallet),
              GestureDetector(
                child: SettingBtn(action: language.language),
                onTap: () => Get.to(const Language()),
              ),
              const UpgadeBtn(),
              InkWell(
                  onTap: () => Get.find<AuthController>().signOut(),
                  child: const SignOutBtn())
            ],
          ),
        ),
      ),
    );
  }
}
