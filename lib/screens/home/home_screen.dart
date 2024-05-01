import 'package:crud_employee/theme/color.dart';
import 'package:flutter/material.dart';

import '../../components/button_component.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Image(
              image: AssetImage('images/welcome.png'),
              height: 340,
              width: 340,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 370,
              child: Text(
                "Welcome To Phoenix Employees Management Application",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 370,
              child: Text(
                "This Application is used for Employee Management. you can add, edit and delete Employee Data.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 370,
              child: Column(
                children: [
                  ButtonComponent(
                    backgroundColor: primary500,
                    labelText: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const LoginScreen()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  ButtonTheme(
                    hoverColor: Colors.white,
                    minWidth: double.infinity,
                    height: 30,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: primary500,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const SignupScreen()),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
