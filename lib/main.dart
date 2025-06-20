import 'dart:async';

import 'package:ace/screens/users/LoginScreen.dart';
import 'package:ace/screens/HomeScreen.dart';
import 'package:ace/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
  // Create an instance of FlutterSecureStorage
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Check the user's authentication status when the screen loads
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Artificial delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Try to read the token from secure storage
    String? token = await storage.read(key: 'auth_token');

    // Navigate based on whether the token exists
    if (token != null) {
      // If user is logged in (token exists), go to HomeScreen
      Get.offAll(() => HomeScreen());
    } else {
      // If user is not logged in, go to LoginScreen
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset("assets/images/acelogo.png"),
        ),
      ),
    );
  }
}