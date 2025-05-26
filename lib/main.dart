import 'dart:async';

import 'package:ace/screens/LoginScreen.dart';
import 'package:ace/screens/SignupScreen.dart';
import 'package:ace/utils/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      bool isLoggedIn = checkUserLoginStatus();
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
  bool checkUserLoginStatus() {
    // Simulating user login check. Replace with SharedPreferences, Firebase, or API call
    return true; // Change this to `true` if user is logged in
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // Set background color
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor, // Background color
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage("assets/images/splash_bg.png"), // Background image
            fit: BoxFit.cover, // Cover the full screen
          ),
        ),
        child: Center(
          child: Image.asset("assets/images/acelogo.png", ), // Your logo
        ),
      ),
    );
  }

}



