import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenpurse/pages/homeScreens/home_screen.dart';
import 'package:greenpurse/pages/onboardingScreen/onboarding_screen.dart';
import 'package:greenpurse/token_manager.dart';
import 'package:greenpurse/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:greenpurse/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the desired status bar color
      statusBarIconBrightness: Brightness
          .dark, // Set the status bar icons and text to be light or dark
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DM Sans',
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: AppColors.customPrimaryColor)
                .copyWith(background: AppColors.white),
      ),
      home: const SplashScreen(),
      // Other MaterialApp configurations
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _progressValue = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  int _loadingDotCount = 1;
  String _loadingText = 'Loading';
  bool isLoggedIn = false; // Move the initialization here

  @override
  void initState() {
    super.initState();

    checkLoggedInStatus();
  }

  Future<void> checkLoggedInStatus() async {
    String? authToken = await TokenManager().getToken();

    if (authToken != null) {
      // Token exists, user is logged in
      context.read<AuthProvider>().setLoggedIn(true);
    }

    // Simulate progress with a Timer
    Timer.periodic(
      const Duration(milliseconds: 500),
      (Timer timer) {
        if (_progressValue >= 1.0) {
          timer.cancel();
          // Check if the widget is still mounted before navigating
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    context.read<AuthProvider>().isLoggedIn
                        ? HomeScreen()
                        : OnboardingScreen(),
              ),
            );
          }
        } else {
          setState(() {
            _progressValue += 0.1;
          });
        }
      },
    );

    // Animation setup for loading text
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);

    // Timer to cycle loading text
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (mounted) {
          setState(() {
            _loadingDotCount = (_loadingDotCount + 1) % 4;
            _loadingText = 'Loading${'.' * _loadingDotCount}';
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green, // Set your custom background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset(
              'assets/green_purse_logo.png', // Replace with your image path
              width: 94.5,
              height: 84,
            ),
            const SizedBox(
                height: 16), // Add some spacing between image and text
            const Text(
              'GREEN PURSE',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // Set your text color
              ),
            ),
            const SizedBox(
                height: 20), // Add some spacing between text and progress bar

            Container(
              width: 200, // Set your desired width for the progress bar
              height: 15, // Set your desired height for the progress bar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded border
                border:
                    Border.all(color: Colors.white, width: 2), // White border
              ),
              child: LinearProgressIndicator(
                value: _progressValue,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.white), // Transparent progress bar color
                backgroundColor:
                    Colors.transparent, // Transparent background color
              ),
            ),
            const SizedBox(
                height: 20), // Add some spacing between text and progress bar
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    _loadingText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white, // Set your text color
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Image.asset(
        "assets/splashscreenbg.png",
        height: MediaQuery.of(context).size.height * 0.30,
      ),
    );
  }
}
