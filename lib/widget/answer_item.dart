import 'package:flutter/material.dart';
enum AnswerState { none, correct, wrong }
class AnswerItem extends StatelessWidget {
  const AnswerItem({
    super.key,
    required this.answer,
    required this.answerState,
    required this.onTap,
  });

  final String answer;
  final AnswerState answerState;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        color: answerState == AnswerState.none
            ? Colors.transparent
            : answerState == AnswerState.correct
                ?  Color(0x5900DB57)
                :  Color(0x8CFF1D1D),
        child: Row(
          children: [
            Icon(
              answerState == AnswerState.none
                  ? Icons.circle_outlined
                  : answerState == AnswerState.correct
                      ? Icons.check_circle
                      : Icons.cancel,
              color: answerState == AnswerState.none
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  color: Colors.black ,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}