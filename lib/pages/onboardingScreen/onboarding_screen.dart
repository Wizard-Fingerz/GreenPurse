import 'package:flutter/material.dart';
import 'package:greenpurse/pages/authenticationScreen/sign_in.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/onboardingBg.png"),
            fit: BoxFit.fill, // You can adjust the BoxFit as needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/green_purse_logo.png",
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10,),
            const Text(
              "Get your groceries delivered to your home",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              "The best delivery app in town for delivering your daily fresh groceries",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
                },
                child: const Text("Shop now",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )))
          ],
        ),
      ),
    );
  }
}
