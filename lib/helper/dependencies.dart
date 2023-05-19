import 'package:a2b/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/update_profile_controller.dart';
import '../main/utils/data_providers.dart';

// Future<void> init() async {
//   await SharedPreferences.getInstance();
//   await initialize(aLocaleLanguageList: languageList());
//   await Firebase.initializeApp().then((value) => Get.put(AuthController()));
//   Get.lazyPut(() => UpdateProfileController());
//   // Get.put(UpdateProfileController());

//   FlutterNativeSplash.remove();
// }
Future<void> init() async {
  try {
    await SharedPreferences.getInstance();
    await initialize(aLocaleLanguageList: languageList());
    await Firebase.initializeApp().then((value) => Get.put(AuthController()));
    Get.lazyPut(() => UpdateProfileController());
    // Get.put(UpdateProfileController());

    FlutterNativeSplash.remove();
  } catch (e) {
    if (e is PlatformException) {
      if (e.code == 'null-error') {
        print('Error: Platform returned null value for non-null return value');
        // Handle the specific null value error
      } else {
        print('Platform Exception occurred: ${e.message}');
        // Handle other types of PlatformExceptions
      }
    } else {
      print('Error occurred during initialization: $e');
      // Handle other types of errors
    }
  }
}
