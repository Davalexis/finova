import 'package:finova/views/onboarding_view/widget/onboarding_button.dart';
import 'package:finova/views/onboarding_view/widget/onboarding_logo.dart';
import 'package:finova/views/onboarding_view/widget/onboarding_text.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body:  Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         children: [
          Spacer(),
           OnboardingLogo(),
           Spacer(),
           OnboardingText(),
           Spacer(),
           OnboardingButton()

           

         ],
       ),
     )

    );
  }
}