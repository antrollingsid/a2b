import 'dart:async';

import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/screens/place_order_calendar.dart';
import 'package:a2b/screens/place_order_map.dart';
import 'package:a2b/screens/place_order_upload.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:a2b/models/models.dart';
import 'package:a2b/screens/place_order_calendar.dart';
import 'package:a2b/screens/place_order_map.dart';
import 'package:a2b/screens/place_order_upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/screens/authentication/login.dart';
import '/screens/authentication/register.dart';
<<<<<<< Updated upstream
import 'main/utils/colors.dart';
=======
import 'app_theme.dart';
>>>>>>> Stashed changes
import 'screens/home_page.dart';
import '/screens/dashboard.dart';
// import 'main/Services/ChatMessagesService.dart';
// import 'main/Services/NotificationService.dart';
// import 'main/Services/UserServices.dart';
import 'main/languages/base_language.dart';
// import 'main/models/FileModel.dart';
import 'main/store/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main/utils/common.dart';
import 'main/utils/constants.dart';
import 'main/utils/data_providers.dart';
import './helper/dependencies.dart' as dep;

AppStore appStore = AppStore();
late BaseLanguage language;
// UserService userService = UserService();
// ChatMessageService chatMessageService = ChatMessageService();
// NotificationService notificationService = NotificationService();
// late List<FileModel> fileList = [];
// bool isCurrentlyOnNoInternet = false;
// late StreamSubscription<Position> positionStream;

// bool mIsEnterKey = false;
// String mSelectedImage = "assets/default_wallpaper.png";

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dep.init();

  // Firebase.initializeApp().then((value) {
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // });
  await initialize(aLocaleLanguageList: languageList());
  // appStore.setLogin(getBoolAsync(IS_LOGGED_IN), isInitializing: true);
  // appStore.setUserEmail(getStringAsync(USER_EMAIL), isInitialization: true);
  appStore.setLanguage(
      getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage));
  // FilterAttributeModel? filterData =
  //     FilterAttributeModel.fromJson(getJSONAsync(FILTER_DATA));
  // appStore.setFiltering(filterData.orderStatus != null ||
  //     !filterData.fromDate.isEmptyOrNull ||
  //     !filterData.toDate.isEmptyOrNull);

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == appThemeMode.themeModeLight) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == appThemeMode.themeModeDark) {
    appStore.setDarkMode(true);
  }

  // await OneSignal.shared.setAppId(mOneSignalAppId);

  // saveOneSignalPlayerId();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return GetMaterialApp(
      //  localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', 'US'), // Set a default locale
      theme: ThemeData(
        fontFamily: 'lucida',
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
      ).copyWith(
        // change the focus border color of the TextField
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(
              primary: AppColors.primary,
            )
            .copyWith(onBackground: const Color(0xffffffff))
            .copyWith(error: const Color.fromARGB(255, 127, 40, 40)),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: "/dashbored", page: () => const DashBoard()),
        GetPage(name: "/ordermap", page: () => const PlaceOrderMap()),
        GetPage(name: "/ordercalendar", page: () => const ConfirmOrder()),
        GetPage(name: "/orderupload", page: () => const PlaceOrderUpload()),
      ],
=======
    return Observer(
      builder: (context) {
        return GetMaterialApp(
          //  localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en', 'US'), // Set a default locale
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          getPages: [
            GetPage(name: '/', page: () => const HomePage()),
            GetPage(name: '/login', page: () => const LoginPage()),
            GetPage(name: '/register', page: () => const Register()),
            GetPage(name: "/dashbored", page: () => const DashBoard()),
            GetPage(name: "/ordermap", page: () => const PlaceOrderMap()),
            GetPage(name: "/ordercalendar", page: () => const ConfirmOrder()),
            GetPage(name: "/orderupload", page: () => const PlaceOrderUpload()),
          ],
        );
      },
>>>>>>> Stashed changes
    );
  }
}
