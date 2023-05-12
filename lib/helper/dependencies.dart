import 'package:a2b/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/update_profile_controller.dart';
import '../main/utils/data_providers.dart';

Future<void> init() async {
  await SharedPreferences.getInstance();
  await initialize(aLocaleLanguageList: languageList());
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  Get.lazyPut(() => UpdateProfileController());
  // Get.put(UpdateProfileController());

  FlutterNativeSplash.remove();
}
