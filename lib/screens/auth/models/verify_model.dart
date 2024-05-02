import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/services/auth_services.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VerifyModels extends ChangeNotifier {
  final TextEditingController _otp1Controller = TextEditingController();
  final TextEditingController _otp2Controller = TextEditingController();
  final TextEditingController _otp3Controller = TextEditingController();
  final TextEditingController _otp4Controller = TextEditingController();
  final TextEditingController _otp5Controller = TextEditingController();
  final TextEditingController _otp6Controller = TextEditingController();

  TextEditingController get otp1Controller => _otp1Controller;
  TextEditingController get otp2Controller => _otp2Controller;
  TextEditingController get otp3Controller => _otp3Controller;
  TextEditingController get otp4Controller => _otp4Controller;
  TextEditingController get otp5Controller => _otp5Controller;
  TextEditingController get otp6Controller => _otp6Controller;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _otp1Controller.dispose();
    _otp2Controller.dispose();
    _otp3Controller.dispose();
    _otp4Controller.dispose();
    _otp5Controller.dispose();
    _otp6Controller.dispose();
    super.dispose();
  }

  String getCombinedOtp() {
    final otp1 = _otp1Controller.text;
    final otp2 = _otp2Controller.text;
    final otp3 = _otp3Controller.text;
    final otp4 = _otp4Controller.text;
    final otp5 = _otp5Controller.text;
    final otp6 = _otp6Controller.text;

    return '$otp1$otp2$otp3$otp4$otp5$otp6';
  }

  Future<void> validateOtp({
    required BuildContext context,
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await AuthServices().verify(
        email: email,
        otp: getCombinedOtp(),
      );

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesNavigation.loginView, (route) => false);
        _otp1Controller.clear();
        _otp2Controller.clear();
        _otp3Controller.clear();
        _otp4Controller.clear();
        _otp5Controller.clear();
        _otp6Controller.clear();
      }
    } catch (e) {
      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    "OTP Verification Failed!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: grey700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "OTP-Code is not valid!",
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
        print("Ini error: $e");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendOtp(
      {required BuildContext context, required String email}) async {
    try {
      await AuthServices().resend(email: email);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primary300,
          content: const Text("OTP-Code sent successfully, Check Your Email!"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Ini errornya: $e");
      }
    }
  }
}
