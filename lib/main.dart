// ignore_for_file: deprecated_member_use, non_constant_identifier_names, prefer_const_constructors, constant_identifier_names, unused_import

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lovebook/Catalogue/54_books.dart';
import 'package:lovebook/Catalogue/55_the_divine_comedy.dart';
import 'package:lovebook/Constance/theme.dart';
import 'package:lovebook/Song/64_song1.dart';
import 'package:lovebook/Song/65_song2.dart';
import 'package:lovebook/Splash/onboarding.dart';
import 'package:lovebook/Splash/spash_screen.dart';
import 'package:lovebook/Stock/49_stock2.dart';
import 'package:lovebook/Stock/50_TWIST.dart';
import 'package:lovebook/Stock/52_TWIST_2.dart';
import 'package:lovebook/Widget/pageview.dart';
import 'package:lovebook/home_screen/11_best_review.dart';
import 'package:lovebook/home_screen/13_liked_the_review.dart';
import 'package:lovebook/home_screen/14_all_review.dart';
import 'package:lovebook/home_screen/15_melanie_strong.dart';
import 'package:lovebook/home_screen/16_passage.dart';
import 'package:lovebook/home_screen/17_passage_2.dart';
import 'package:lovebook/home_screen/19_Recommendations_1.dart';
import 'package:lovebook/home_screen/20_recommendations_2.dart';
import 'package:lovebook/home_screen/21_recommendations3.dart';
import 'package:lovebook/home_screen/22_filter.dart';
import 'package:lovebook/home_screen/26_search_history.dart';
import 'package:lovebook/home_screen/27_search_photo.dart';
import 'package:lovebook/home_screen/28_cart_is_empty.dart';
import 'package:lovebook/home_screen/29_cart_is_empty_1.dart';
import 'package:lovebook/home_screen/30_cart_is_empty_2.dart';
import 'package:lovebook/home_screen/31_new_address.dart';
import 'package:lovebook/home_screen/32_courier.dart';
import 'package:lovebook/home_screen/33_pickup.dart';
import 'package:lovebook/home_screen/34_complete.dart';
import 'package:lovebook/home_screen/screen/25_search.dart';
import 'package:lovebook/home_screen/screen/9_FROM_HELL.dart';
import 'package:lovebook/message/69_message2_Screen.dart';
import 'package:lovebook/message/70_message3Screen.dart';
import 'package:lovebook/utils/local_storage_data.dart';
import 'package:lovebook/utils/music_player_util/audio_handler.dart';
import 'package:lovebook/utils/navigation_service.dart';
import 'package:lovebook/utils/themes/theme_manager.dart';

import 'auth/register.dart';
import 'home_screen/test_audio.dart';

late AudioHandler audioHandler;
Future<void> main() async {
  //audio init
  audioHandler = await initAudioService();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(ProviderScope(child: const MyApp())),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
          statusBarBrightness:
              AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarDividerColor: Colors.grey,
          systemNavigationBarIconBrightness:
              AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
        ),
      ),
    );
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeController);
      return GetMaterialApp(
        navigatorKey: NavigationService.navigatorKey,

        scrollBehavior: const ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        title: "Lovebook",
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        routes: routes,
        onGenerateRoute: (settings) {
          LocalDataStorage.getUserData().then((value) {
            print("Hello dear");
          });

          return null;
        },
        // home: Message3Screen(),
      );
    });
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.INTRODUCTION: (BuildContext context) => OnBoardingScreen(),
    Routes.HOME: (BuildContext context) => PageScreen(),
    Routes.signInScreen: (context) => const RegisterScreen(),
  };
}

class Routes {
  static String SPLASH = "/";
  static const String INTRODUCTION = "/Splash/onboarding";
  static const String HOME = "/home/HomeScreen1";
  static const String signInScreen = "/signInScreen";
}

class NavKey {
  static final navKey = GlobalKey<NavigatorState>();
}
