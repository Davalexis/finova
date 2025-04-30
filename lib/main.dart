import 'package:finova/views/Navigation_view/navigation_screen.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';
import 'package:finova/views/onboarding_view/screen/onboarding_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Finavo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black ,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: OnboardingScreen(),
    );
  }
}
