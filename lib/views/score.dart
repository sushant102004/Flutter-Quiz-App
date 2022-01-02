import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizapp/views/questionsscreen.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
              text: "Quiz",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(text: " App", style: TextStyle(color: Colors.black))
              ]),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 300)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your Scored:",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                " $currentScore",
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const QuestionsScreen(),
                          type: PageTransitionType.leftToRight));
                },
                child: const Text("Restart Quiz")),
          )
        ],
      ),
    );
  }
}
