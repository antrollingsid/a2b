import 'package:flutter/material.dart';

import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/settings_button.dart';
import '../../Components/widgets/sign_out_btn.dart';
import '../../Components/widgets/top_profile.dart';
import '../../Components/widgets/upgrade_button.dart';
import '../../main/utils/colors.dart';

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
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
             TopProfile(),
              SettingBtn(action: 'Edit Profile'),
              SettingBtn(action: 'Settings'),
              SettingBtn(action: 'Wallets'),
              UpgadeBtn(),
              SignOutBtn()
            ],
          ),
        ),
      ),
    );
  }
}