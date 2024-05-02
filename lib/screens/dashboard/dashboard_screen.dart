import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/constant/routes_navigation.dart';
import 'package:crud_employee/screens/dashboard/models/dashboard_model.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:crud_employee/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<DashboardModels>(context, listen: false)
        .isAuthorized(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary500,
        title: const Row(
          children: [
            Image(
              image: AssetImage('images/vector.png'),
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              "Phoenix Company",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Consumer<DashboardModels>(
        builder: (context, dashboardModels, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: dashboardModels.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Image(
                            image: AssetImage('images/welcome.png'),
                            height: 340,
                            width: 340,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 370,
                            child: Text(
                              "Welcome To Phoenix Employees Management Page!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Open Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            width: 370,
                            child: Text(
                              "Click the button below, to manage employees.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 370,
                            child: Column(
                              children: [
                                ButtonComponent(
                                  backgroundColor: primary500,
                                  labelText: const Center(
                                    child: Text(
                                      "Data Employees",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        RoutesNavigation.listEmployeeView);
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      "Sign Out",
                                      style: TextStyle(
                                          color: primary500,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () async {
                                      await SharedPreferencesUtils()
                                          .removeToken();
                                      if (!context.mounted) return;
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RoutesNavigation.homeView,
                                          (routes) => false);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
