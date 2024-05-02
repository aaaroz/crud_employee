import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/services/auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardModels extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> isAuthorized({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isAuth = await AuthServices().isAuthorized();

      if (context.mounted && !isAuth) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesNavigation.splashView,
          (route) => false,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}
