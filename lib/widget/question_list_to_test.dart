import 'package:flutter/material.dart';
import 'package:gplx/widget/answer_item.dart';

class QuestionListToTest extends StatelessWidget {
  const QuestionListToTest({
    super.key,
    required this.questionStatuses,
    required this.onQuestionSelected,
  });

  final List<AnswerState> questionStatuses;
  final void Function(int) onQuestionSelected;

  Widget _buildAnswerTile(AnswerState answerState, int index) {
    final String text = (index + 1).toString();
    final Color color;
    switch (answerState) {
      case AnswerState.notAnswered:
        color = Colors.transparent;
        break;
      case AnswerState.answered:
        color = Colors.blue;
        break;
      case AnswerState.correct:
        color = const Color(0x5900DB57);
        break;
      case AnswerState.wrong:
        color = const Color(0x8CFF1D1D);
        break;
    }
    return InkWell(
      onTap: () => onQuestionSelected(index),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: [
        for (var i = 0; i < questionStatuses.length; i++)
          _buildAnswerTile(questionStatuses[i], i),
      ],
    );
  }
}