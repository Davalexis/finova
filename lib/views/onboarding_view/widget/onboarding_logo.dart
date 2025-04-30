import 'package:flutter/material.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Row(
          spacing: 0,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              ),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
            ),
          ],
        ),

        Text(
          'Planoo',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
