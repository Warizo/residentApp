import 'dart:async';

import 'package:resident_app/route/routing_constant.dart';
import 'package:flutter/material.dart';
import 'package:resident_app/route/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: SplashScreenRoute,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLoggedIn = false;

  Future<void> getProfile() async {
    final preff = await SharedPreferences.getInstance();

    setState(() {
      if (mounted) {
        this.isLoggedIn = preff.getBool("isLoggedIn");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        isLoggedIn == true ? DashboardScreenRoute : LoginScreenRoute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo here
            Image(
              image: const AssetImage("assets/images/romakop_logo.png"),
              width: MediaQuery.of(context).size.width / 1.5,
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'ERM APP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            // Loading circular
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
