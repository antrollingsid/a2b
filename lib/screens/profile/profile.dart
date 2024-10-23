import 'package:a2b/Components/assets/fonts.dart';
import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/screens/apply_for_courier.dart';
import 'package:a2b/screens/offers/accepted_offers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../Components/widgets/app_bar_buttons.dart';
import '../../../../Components/widgets/settings_button.dart';
import '../../Components/widgets/logout_btn.dart';
import '../../controllers/update_profile_controller.dart';
import '../../main/utils/colors.dart';
import '../messages.dart';
import '../offers/courier_offer_list.dart';
import '../order_history.dart';
import '../userDetails/courierList/courier-list.dart';
import '../userDetails/courierList/user_list.dart';
import 'info/top_profile.dart';
import '../../../../main.dart';

final UpdateProfileController ctrl = Get.put(UpdateProfileController());

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
    final userRole = Get.put(AuthController());
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (controller.isLoggedIn) {
          print(controller.user.details.name);
        } else {
          print(controller.user.details.name);
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            centerTitle: true,
            title: Text(
              language.profile,
              style: TextStyle(
                color: appStore.isDarkMode
                    ? AppColors.onBackgroundDark
                    : AppColors.onBackgroundLight,
                fontSize: 18,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            leading: const backBtn(),
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
                            : AppColors.backgroundLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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
                            : AppColors.backgroundLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 333,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 60, 0),
                                  child: Stack(children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 148, 34, 34),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: VerticalDivider(
                                    width: 3,
                                    thickness: 2,
                                    color: appStore.isDarkMode
                                        ? AppColors.onBackgroundDark
                                        : AppColors.onBackgroundLight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                language.email,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            controller.user.details.email,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                language.phoneNumber,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _changePhoneNumberPressed(
                                                      context,
                                                      ctrl.phoneNumber);
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            controller.user.details.phone,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        controller.user.details.name,
                                        style: TextStyle(
                                          fontFamily: AppFonts.mainFont,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w500,
                                          color: appStore.isDarkMode
                                              ? AppColors.onBackgroundDark
                                              : AppColors.onBackgroundLight,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _changeNamePressed(
                                                context, ctrl.name);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 12,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        controller.user.details.surname,
                                        style: TextStyle(
                                          fontFamily: AppFonts.mainFont,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _changeSurNamePressed(
                                                context, ctrl.surname);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 12,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const MessagesList()),
                      child: SettingBtn(action: language.messages),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    if (userRole.user.role == 'general')
                      Column(
                        children: [
                          InkWell(
                            onTap: () => Get.to(() => const ApplyForCourier()),
                            child: SettingBtn(action: language.applyForCourier),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const CourierList()),
                            child: SettingBtn(action: language.couriers),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const CourierOfferList()),
                            child: SettingBtn(action: language.offers),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const OrderHistoryList()),
                            child: SettingBtn(action: language.orderHistory),
                          ),
                        ],
                      )
                    else if (userRole.user.role == 'courier')
                      Column(
                        children: [
                          InkWell(
                            onTap: () => Get.to(() => const UserList()),
                            child: const SettingBtn(action: 'Users'),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => const AcceptedOffers()),
                            child: const SettingBtn(action: 'Accepted offers'),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () => Get.find<AuthController>().signOut(),
                      child: LogoutBtn(action: language.logout),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

_changeNamePressed(context, TextEditingController mycontroller) {
  Alert(
      context: context,
      title: "Change Your Firstname",
      content: Column(
        children: <Widget>[
          TextField(
            controller: mycontroller,
            decoration: const InputDecoration(
              icon: Icon(Icons.verified_user_rounded),
              labelText: 'Firstname',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppColors.buttonBlue,
          onPressed: () {
            ctrl.updateName(ctrl.name.text);
            Navigator.pop(context);
          },
          child: const Text(
            "Change",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_changeSurNamePressed(context, TextEditingController mycontroller) {
  Alert(
      context: context,
      title: "Change Your Surname",
      content: Column(
        children: <Widget>[
          TextField(
            controller: mycontroller,
            decoration: const InputDecoration(
              icon: Icon(Icons.verified_user_rounded),
              labelText: 'Surnane',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppColors.buttonBlue,
          onPressed: () {
            ctrl.updateSurname(ctrl.surname.text);
            Navigator.pop(context);
          },
          child: const Text(
            "Change",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_changePhoneNumberPressed(context, TextEditingController mycontroller) {
  Alert(
      context: context,
      title: "Change Your Number",
      content: Column(
        children: <Widget>[
          TextField(
            controller: mycontroller,
            decoration: const InputDecoration(
              icon: Icon(Icons.verified_user_rounded),
              labelText: 'Phone number',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppColors.buttonBlue,
          onPressed: () {
            ctrl.updatePhoneNumber(ctrl.phoneNumber.text);
            Navigator.pop(context);
          },
          child: const Text(
            "Change",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
