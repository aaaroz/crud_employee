import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/components/text_field_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/screens/auth/models/login_model.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Provider.of<LoginModels>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(18, 26, 18, 26),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(child: Consumer<LoginModels>(
            builder: (context, loginModels, child) {
              return Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          "Welcome Back 👋",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.left,
                          "Sign in to your account",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            height: 0.7,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFieldComponent(
                        controller: loginModels.emailController,
                        hintText: "Your Email",
                        hinstStyle: const TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !loginModels.validateEmail(value)) {
                            return 'Your Email is not valid, e.g: johndoe@example.com';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            height: 0.7,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFieldComponent(
                        controller: loginModels.passwordController,
                        obscureText: !loginModels.passwordVisible,
                        hintText: "Your Password",
                        hinstStyle: const TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginModels.togglePassword();
                          },
                          icon: Icon(
                            loginModels.passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: grey500,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please insert your password first!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonComponent(
                        backgroundColor: primary500,
                        labelText: loginModels.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Center(
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
                          if (formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(context);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14, color: grey700),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesNavigation.signupView);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: primary500,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
