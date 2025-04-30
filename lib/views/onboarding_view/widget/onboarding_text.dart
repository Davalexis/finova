import 'dart:async';

import 'package:flutter/material.dart';


class OnboardingText extends StatefulWidget {
  const OnboardingText ({super.key});

  @override
  State<OnboardingText> createState() => _OnboardingTextState();
}

class _OnboardingTextState extends State<OnboardingText> {
  final List<String> rotatingWord = ['Goal', 'Life', 'Plan'];

  int currenWordIndex = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startWordRotation();
  }

  void _startWordRotation() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currenWordIndex = (currenWordIndex + 1) % rotatingWord.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
        style: TextStyle(
          color: Colors.white,
          height: 1.3,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: 'Get ready to \n'),
          TextSpan(
            text: 'supercharge\n',
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(text: 'your Be '),

          WidgetSpan(
            child: AnimatedSwitcher(
              duration: Duration(microseconds: 1000),
              transitionBuilder: (Widget child, Animation) {
                return FadeTransition(
                  opacity: Animation,
                  child: RotationTransition(turns: Animation, child: child),
                );
              },
              child: Text(
                rotatingWord[currenWordIndex],
                key: ValueKey(currenWordIndex),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),

          TextSpan(text: '\nsetting and \n'),
          TextSpan(text: 'planning with \n'),
          TextSpan(text: 'AI planner'),
        ],
      ),
    );
  }
}
