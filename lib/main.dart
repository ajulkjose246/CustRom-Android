import 'package:custrom/screens/splash_screen_2.dart';
import 'package:custrom/screens/splash_screen_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: ({
        "/splashScreen1": (context) => const SplashScreen1(),
        "/splashScreen2": (context) => const SplashScreen2(),
      }),
      initialRoute: "/splashScreen1",
    );
  }
}
