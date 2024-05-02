import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/services/auth_services.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginModels extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  bool validateEmail(String email) {
    final emailPattern =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailPattern.hasMatch(email)) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginAccount({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await AuthServices().login(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );

      _emailController.clear();
      _passwordController.clear();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.dashboardView,
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    "Login Failed | Something Went Wrong!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: grey700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Email or Password is wrong!",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: grey700),
                  ),
                  const SizedBox(height: 16),
                  ButtonComponent(
                    labelText: const Text(
                      "Try Again",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: primary500,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        );
      }
      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false; // loading state
      notifyListeners();
    }
  }

  Future<void> isAuthorized({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isAuth = await AuthServices().isAuthorized();

      if (context.mounted && isAuth) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.dashboardView,
          (route) => false,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
