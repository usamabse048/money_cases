import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_cases/constants/controllers.dart';
import 'package:money_cases/constants/global_constant.dart';
import 'package:money_cases/controllers/auth_controller.dart';
import 'package:money_cases/controllers/transaction_controller.dart';
import 'package:money_cases/controllers/user_controller.dart';
import 'package:money_cases/screens/add_transaction_screen.dart';
import 'package:money_cases/screens/home_screen.dart';
import 'package:money_cases/screens/login_screen.dart';
import 'package:money_cases/screens/signup_screen.dart';
import 'package:money_cases/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GlobalConstant.getSharedPrefrence();

  Get.put(AuthController());
  Get.put(TransactionController());
  Get.put(UserController());
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
        LoginScreen.route: (context) => const LoginScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        TransactionScreen.route: (context) => const TransactionScreen()
      },
      home: FutureBuilder(
        future: authController.checkLogingState(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : snapshot.data as bool
                  ? HomeScreen()
                  : LoginScreen();
          //return authResult.data as bool ? HomeScreen() : LoginScreen();
        },
      ),
      //home: const LoginScreen(),

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
