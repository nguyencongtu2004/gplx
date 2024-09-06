import 'package:flutter/material.dart';
import 'package:gplx/widget/answer_item.dart';

class QuestionListToTest extends StatelessWidget {
  const QuestionListToTest({
    super.key,
    required this.questionStatuses,
    required this.onQuestionSelected,
    required this.selectingPage,
  });

  final List<AnswerState> questionStatuses;
  final void Function(int) onQuestionSelected;
  final int selectingPage;

  Widget _buildAnswerTile(BuildContext context, AnswerState answerState, int index) {
    final isSelecting = selectingPage == index;
    final String text = (index + 1).toString();
    Color backgroundColor = switch(answerState) {
      AnswerState.none => Colors.transparent,
      AnswerState.answered => Colors.blue,
      AnswerState.correct => const Color(0x5900DB57),
      AnswerState.wrong => const Color(0x8CFF1D1D),
      AnswerState.notAnswered => Colors.transparent,
    };

    return InkWell(
      onTap: () => onQuestionSelected(index),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelecting ? Colors.blue : Colors.transparent,
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        padding: const EdgeInsets.all(4),
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.black,
            ),
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
          _buildAnswerTile(context, questionStatuses[i], i),
      ],
    );
  }
}