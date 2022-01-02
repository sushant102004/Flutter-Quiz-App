// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnswerWidget extends StatelessWidget {
  String answerText;
  final Color answerBackgroundColor;
  final Function answerTapped;

  AnswerWidget(
      {Key? key,
      required this.answerText,
      required this.answerBackgroundColor,
      required this.answerTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => answerTapped(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: answerBackgroundColor),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(answerText,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }
}
