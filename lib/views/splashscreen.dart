import 'dart:async';
import 'package:quizapp/views/questionsscreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      Timer(
          const Duration(seconds: 2),
          () => {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const QuestionsScreen(),
                        type: PageTransitionType.leftToRight))
              });
    });
    return Scaffold(
      body: Center(
        child: RichText(
          text: const TextSpan(
              text: "Quiz",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(text: " App", style: TextStyle(color: Colors.black))
              ]),
        ),
      ),
    );
  }
}
