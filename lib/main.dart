import 'package:custrom/components/shared_preferences.dart';
import 'package:custrom/firebase_options.dart';
import 'package:custrom/screens/home_screen.dart';
import 'package:custrom/screens/splash_screen_2.dart';
import 'package:custrom/screens/splash_screen_1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var deviceCodeName = SharedPreferencesService().getDeviceCode();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: ({
        "/splashScreen1": (context) => const SplashScreen1(),
        "/splashScreen2": (context) => const SplashScreen2(),
        "/": (context) => const HomeScreen(),
      }),
      initialRoute: deviceCodeName != null ? "/" : "/splashScreen1",
    );
  }
}
