import 'package:page_transition/page_transition.dart';
import 'package:quizapp/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/views/score.dart';
import 'package:quizapp/widgets/answerwidget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

int currentScore = 0;

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<Icon> scoreTrackerIcons = [];
  int indexOfQuestion = 0;
  bool isAnswerSelected = false;
  bool isQuizEnded = false;
  bool isIconAdded = false;

  final questionsDataInstance = QuestionsData();

  void nextQuestion() {
    setState(() {
      indexOfQuestion++;
      isAnswerSelected = false;
      isIconAdded = false;
      if (indexOfQuestion >= questionsDataInstance.questions.length) {
        showScore();
      }
    });
  }

  void showScore() {
    scoreTrackerIcons = [];
    indexOfQuestion = 0;
    isAnswerSelected = false;
    isQuizEnded = false;
    isIconAdded = false;
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const ScoreScreen(), type: PageTransitionType.fade));
  }

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
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (scoreTrackerIcons.isEmpty) const SizedBox(height: 20),
                if (scoreTrackerIcons.isNotEmpty) ...scoreTrackerIcons
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
            width: double.infinity,
            child: Center(
                child: Text(
                    questionsDataInstance.questions[indexOfQuestion]['question']
                        as String,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500))),
          ),

          // Options
          ...(questionsDataInstance.questions[indexOfQuestion]["answers"]
                  as List<Map<String, Object>>)
              .map((element) => AnswerWidget(
                  answerText: element["text"] as String,
                  answerBackgroundColor: isAnswerSelected
                      ? element["isCorrect"] == true
                          ? Colors.green
                          : Colors.red
                      : Colors.black,
                  answerTapped: () {
                    setState(() {
                      isAnswerSelected = true;
                      bool answerStatus = element["isCorrect"] as bool;
                      if (answerStatus == true && isIconAdded == false) {
                        scoreTrackerIcons
                            .add(const Icon(Icons.check, color: Colors.green));
                        setState(() {
                          isIconAdded = true;
                          currentScore++;
                        });
                      }
                      if (answerStatus == false && isIconAdded == false) {
                        scoreTrackerIcons
                            .add(const Icon(Icons.clear, color: Colors.red));
                        setState(() {
                          isIconAdded = true;
                        });
                      }

                      if (indexOfQuestion + 1 ==
                          questionsDataInstance.questions.length) {
                        isQuizEnded = true;
                      }
                    });
                  })),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  if (isAnswerSelected == true) {
                    nextQuestion();
                  } else {
                    const snackBar =
                        SnackBar(content: Text("Answer This Question First"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(isQuizEnded ? "Show Result" : "Next Question")),
          ),
        ],
      ),
    );
  }
}
