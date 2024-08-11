import 'package:flutter/material.dart';
import 'package:gplx/widget/answer_item.dart';

class ExplanationItem extends StatelessWidget {
  const ExplanationItem({
    super.key,
    required this.explanation,
    required this.answerState,
    required this.correctAnswer,
  });

  final String explanation;
  final AnswerState answerState;
  final int correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: answerState == AnswerState.correct ? const Color(0xFFCFF5DE) : const Color(0xFFFFCECE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(answerState == AnswerState.correct ? Icons.check_circle : Icons.cancel),
              const SizedBox(width: 8),
              Text(
                answerState == AnswerState.correct ? 'ĐÚNG' : 'SAI - Đáp án đúng là số $correctAnswer',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Giải thích:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            explanation,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}