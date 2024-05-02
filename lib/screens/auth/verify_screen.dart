import 'package:crud_employee/components/button_component.dart';
import 'package:crud_employee/screens/auth/models/verify_model.dart';
import 'package:crud_employee/screens/auth/widgets/otp_widget.dart';
import 'package:crud_employee/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    final String email = args;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: SingleChildScrollView(
          child: Consumer<VerifyModels>(
            builder: (context, verifyModels, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      "Email Verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                      child: Column(
                    children: [
                      Text(
                        "Please enter the OTP-Code we just sent to your email.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: grey500,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 2,
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpWidget(
                        otpController: verifyModels.otp1Controller,
                      ),
                      OtpWidget(
                        otpController: verifyModels.otp2Controller,
                      ),
                      OtpWidget(
                        otpController: verifyModels.otp3Controller,
                      ),
                      const Text(
                        "-",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      OtpWidget(
                        otpController: verifyModels.otp4Controller,
                      ),
                      OtpWidget(
                        otpController: verifyModels.otp5Controller,
                      ),
                      OtpWidget(
                        otpController: verifyModels.otp6Controller,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the OTP-Code?",
                        style: TextStyle(fontSize: 14, color: grey700),
                      ),
                      TextButton(
                        onPressed: () {
                          verifyModels.resendOtp(
                              context: context, email: email);
                        },
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              fontSize: 14,
                              color: primary500,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonComponent(
                    backgroundColor: primary500,
                    labelText: verifyModels.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    onPressed: () {
                      verifyModels.validateOtp(context: context, email: email);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
