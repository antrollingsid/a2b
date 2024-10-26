import 'package:a2b/screens/home_page.dart';
import 'package:a2b/screens/createOrder/order_map.dart';
import 'package:a2b/screens/notifications/notifications.dart';
import 'package:a2b/screens/place_order_upload.dart';
import 'package:a2b/screens/profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/screens/authentication/login.dart';
import '/screens/authentication/register.dart';
import 'app_theme.dart';
import 'screens/dashboard/dashboard.dart';
import 'main/languages/base_language.dart';
import 'main/store/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // Listneing to the foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Noti.showBigTextNotification(
        title: "'Got a message whilst in the foreground!'",
        body: "Message data: ${message.data}",
        fln: flutterLocalNotificationsPlugin);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  // await OneSignal.shared.setAppId(mOneSignalAppId);

  // saveOneSignalPlayerId();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
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
            GetPage(name: "/orderupload", page: () => const PlaceOrderUpload()),
            GetPage(name: "/profile", page: () => const Profile()),
          ],
        );
      },
    );
  }
}
//just for commit