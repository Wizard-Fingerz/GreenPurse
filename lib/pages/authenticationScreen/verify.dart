// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenpurse/ApiServices/authentication_api_services.dart';
import 'package:greenpurse/pages/homeScreens/home_screen.dart';
import 'package:greenpurse/token_manager.dart';
import 'package:greenpurse/utils/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  int countdown = 150; // 2 and half minutes in seconds
  bool isResendDisabled = false; // Add this variable

  Future<void> _verifyOTP(String otp) async {
    final token = await TokenManager().getToken();

    if (token == null) {
      // Handle the case where the token is not available.
      // You might want to navigate the user to the login screen.
      return;
    }

    final apiService = AuthenticationApiService();

    final response = await apiService.verifyOTP(otp, token);

    print(response.body);

    if (response.statusCode == 200) {
      // Verification succeeded, navigate to the home screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              const HomeScreen(), // Replace with your home screen widget
        ),
      );
    } else {
      // Handle OTP verification failure
      if (response.body != null) {
        final errorResponse = json.decode(response.body);
        if (errorResponse != null && errorResponse is Map) {
          final errorMessage = errorResponse['error'];
          if (errorMessage != null && errorMessage is String) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
              ),
            );
          } else {
            // If the 'error' field is not a string, show a generic error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incorrect OTP. Please try again.'),
              ),
            );
          }
        } else {
          // If the response body is not a Map, show a generic error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect OTP. Please try again.'),
            ),
          );
        }
      } else {
        // If the response body is null, show a generic error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect OTP. Please try again.'),
          ),
        );
      }
    }
  }

  Future<void> resendOTP() async {
    if (isResendDisabled) {
      return;
    }

    isResendDisabled = true; // Disable the Resend button
    countdown = 150; // Restart the countdown
    startCountdown();

    final token = await TokenManager().getToken();

    if (token == null) {
      // Handle the case where the token is not available.
      // You might want to navigate the user to the login screen.
      return;
    }

    final apiService = AuthenticationApiService();

    final response = await apiService.resendOTP(token);

    if (response.statusCode == 200) {
      // Successfully resent the OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New OTP code has been sent.'),
        ),
      );
    } else {
      // Handle API errors here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to resend OTP code. Please try again.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  // void startCountdown() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (countdown > 0) {
  //         countdown--;
  //       } else {
  //         timer.cancel(); // Stop the countdown when it reaches 0
  //       }
  //     });
  //   });
  // }

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel(); // Stop the countdown when it reaches 0
          isResendDisabled = false; // Enable the Resend button
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Image.asset("assets/green_purse_logo.png"),
              const Text("Set your pin code",
                  textAlign: TextAlign.center, // Center-align the text
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 10),
              const Text("Confirm your transactions using your four digit pin code.",
                  textAlign: TextAlign.center, // Center-align the text
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 5, // Define the length of the OTP
                controller: _otpController,
                onChanged: (otp) {
                  // Handle OTP changes
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 55,
                  fieldWidth: 53,
                  activeFillColor:
                      AppColors.green, // Set the filled color to purple
                  inactiveFillColor: Colors
                      .transparent, // Make the inactive (unfilled) boxes transparent
                  activeColor: AppColors
                      .green, // Set the border color to purple when active
                  inactiveColor: AppColors
                      .green, // Set the border color to purple when inactive
                  selectedColor:
                      AppColors.green, // Set the border color when selected
                  selectedFillColor:
                      AppColors.green, // Set the filled color when selected
                ),
                keyboardType: TextInputType.number,
                autoFocus: true,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                enableActiveFill: true,
                onCompleted: (otp) {
                  // Called when all the OTP digits are entered
                  // You can perform OTP verification here
                  _verifyOTP(otp);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDuration(Duration(seconds: countdown)),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: countdown == 0 ? resendOTP : null,
                      child: const Text(
                        "Didn’t get code? Resend code",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration:
                              TextDecoration.underline, // Underline the text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              ElevatedButton(
                onPressed: _otpController.text.length ==
                        5 // Check if OTP is filled
                    ? () {
                        String otp = _otpController.text;
                        _verifyOTP(otp);
                      }
                    : null, // Set onPressed to null to disable the button if OTP is not filled
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      // Set the color for the disabled state here
                      return AppColors.green; // Replace with your desired color
                    }
                    return AppColors.green; // Color for the enabled state
                  }),
                  minimumSize: MaterialStateProperty.all(const Size(500, 60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: VerifyOTPScreen(),
  ));
}
