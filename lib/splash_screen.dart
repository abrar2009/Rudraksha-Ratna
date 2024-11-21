import 'package:flutter/material.dart';
import 'dart:async'; // Import this for Future.delayed

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay navigation for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/homepage'); // Replace with your home route
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Rudraksha-Ratna',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
