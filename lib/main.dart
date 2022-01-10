import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_cases/controllers/auth_controller.dart';
import 'package:money_cases/screens/home_screen.dart';
import 'package:money_cases/screens/login_screen.dart';
import 'package:money_cases/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Cases',
      routes: {
        SignUpScreen.route: (context) => const SignUpScreen(),
        //LoginScreen.route:(context) => const LoginScreen()
        HomeScreen.route: (context) => const HomeScreen(),
      },
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
    );
  }
}
