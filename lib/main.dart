import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/screens/auth/login_screen.dart';
import 'package:crud_employee/screens/auth/models/login_model.dart';
import 'package:crud_employee/screens/auth/models/signup_model.dart';
import 'package:crud_employee/screens/auth/models/verify_model.dart';
import 'package:crud_employee/screens/auth/signup_screen.dart';
import 'package:crud_employee/screens/auth/verify_screen.dart';
import 'package:crud_employee/screens/splash/splash_screen.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginModels(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupModels(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyModels(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: primary500),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesNavigation.splashView,
        routes: {
          RoutesNavigation.splashView: (context) => const SplashScreen(),
          RoutesNavigation.loginView: (context) => const LoginScreen(),
          RoutesNavigation.signupView: (context) => const SignupScreen(),
          RoutesNavigation.verifyView: (context) => const VerifyScreen()
        },
      ),
    );
  }
}
