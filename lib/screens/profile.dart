import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/screens/applyForCourier/apply_for_courier.dart';
import 'package:a2b/screens/editProfile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/settings_button.dart';
import '../../Components/widgets/sign_out_btn.dart';
import '../../Components/widgets/top_profile.dart';
import '../../Components/widgets/upgrade_button.dart';
import '../../main.dart';
import 'pick_language.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Profile',
          isActionVisible: false,
        ),
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
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SettingBtn(action: 'Settings'),
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),

                SettingBtn(action: language.wallet),
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                GestureDetector(
                  child: SettingBtn(action: language.language),
                  onTap: () => Get.to(() => const Language()),
                ),
                // GestureDetector(
                //   child: const SettingBtn(action: 'apply for couriership'),
                //   onTap: () => Get.to(() => const ApplyForCourier()),
                // ),
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                InkWell(
                    onTap: () => Get.to(() => const ApplyForCourier()),
                    child: const UpgadeBtn()),
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                InkWell(
                  child: const Icon(LineIcons.sun),
                  onTap: () {
                    print('this is light modde');
                    appStore.setDarkMode(false);
                    print('we set light mode to true');
                    setValue(THEME_MODE_INDEX, 1);
                    setState(() {});
                    LiveStream().emit('UpdateTheme');
                    // finish(context);
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
                    // finish(context);
                  },
                ),
                Container(
                  width: 290,
                  height: 1,
                  color: Theme.of(context).iconTheme.color,
                ),
                InkWell(
                    onTap: () => Get.find<AuthController>().signOut(),
                    child: const SignOutBtn())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
