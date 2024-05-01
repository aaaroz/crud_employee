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

  final bool _isLoading = false;
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
}
