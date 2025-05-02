import 'package:finova/views/Auth_view/screen/create_acct_screen.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAcctScreen()));
      },
      child: Text(
        'Get Started',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
