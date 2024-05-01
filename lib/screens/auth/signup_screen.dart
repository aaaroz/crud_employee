import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/components/text_field_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/screens/auth/models/signup_model.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    Provider.of<SignupModels>(context, listen: false);
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
          child: SingleChildScrollView(child: Consumer<SignupModels>(
            builder: (context, signupModels, child) {
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
                          "Hello 👋",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.left,
                          "Create your account first!",
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
                        "Name",
                        style: TextStyle(
                            height: 0.7,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFieldComponent(
                        controller: signupModels.nameController,
                        hintText: "Your Name",
                        hinstStyle: const TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please insert your name first!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            height: 0.7,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFieldComponent(
                        controller: signupModels.emailController,
                        hintText: "Your Email",
                        hinstStyle: const TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !signupModels.validateEmail(value)) {
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
                        controller: signupModels.passwordController,
                        obscureText: !signupModels.passwordVisible,
                        hintText: "Your Password",
                        hinstStyle: const TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                          onPressed: () {
                            signupModels.togglePassword();
                          },
                          icon: Icon(
                            signupModels.passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: grey500,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please insert your password first!";
                          } else if (!signupModels.validatePassword(value)) {
                            return "Password must be at least 8 characters, and must be contains 1 Capital, and 1 number.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                            height: 0.7,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFieldComponent(
                        controller: signupModels.confirmPasswordController,
                        obscureText: !signupModels.confirmPasswordVisible,
                        hintText: "Confirm Password",
                        hinstStyle: const TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                          onPressed: () {
                            signupModels.toggleConfirmPassword();
                          },
                          icon: Icon(
                            signupModels.confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: grey500,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please insert your confirm password!';
                          } else if (!signupModels.validatePassword(value)) {
                            return "Password must be at least 8 characters, and must be contains 1 Capital, and 1 number.";
                          } else if (value !=
                              signupModels.passwordController.text) {
                            return 'Your password did not match!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonComponent(
                        backgroundColor: primary500,
                        labelText: signupModels.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                        onPressed: () {
                          // if (formKey.currentState!.validate()) {
                          //   if (kDebugMode) {
                          //     print(context);
                          //   }
                          // }
                          Navigator.pushNamed(
                              context, RoutesNavigation.verifyView);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 14, color: grey700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: primary500,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "By clicking Register, You agree to our",
                            style: TextStyle(fontSize: 14, color: grey700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Terms and Data Policy.",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: primary500,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
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
