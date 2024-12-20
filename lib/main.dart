import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_resume/utils/app_theme.dart';

import 'controller/controller_singletons.dart';
import 'controller/general_config_controller.dart';
import 'food_kart.dart';
import 'home_screen.dart';
import 'utils/extension.dart';
import 'welcome_screen.dart';

final getIt = GetIt.instance;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      singletonSetup();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      log("Error Caught", error: error, stackTrace: stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    generalConfigController.dheight.value = MediaQuery.of(context).size.height;
    generalConfigController.dwidth.value = MediaQuery.of(context).size.width;
    generalConfigController.safePadding.value =
        MediaQuery.of(context).padding.top;
    return GetMaterialApp(
      title: 'My Portfolio',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: generalConfigController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      // home: const WelcomeScreen(),
      home: const FoodKart(),
    );
  }
}
