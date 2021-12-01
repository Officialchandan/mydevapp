import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mydevapp/sreen/spleash_sreen.dart';

import 'getx_state_manegement/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Future.delayed(const Duration(seconds: 5));
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GetMaterialApp(home: Splash());
          } else {
            // Loading is done, return the app:
            return GetMaterialApp(
              key: key,
              // routes: {
              //   '/login': (context) => const MyApp(),
              //   '/homepage': (context) => const HomePage(),
              // },
              theme: ThemeData(),
              debugShowCheckedModeBanner: false,

              // locale: context.locale,
              home: Scaffold(body: ProductHomePage()),
            );
          }
        });
  }
}
