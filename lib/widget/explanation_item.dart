import 'package:flutter/material.dart';

class ExplanationItem extends StatelessWidget {
  ExplanationItem({
    super.key,
    required this.explanation,
    required this.isCorrect,
    required this.correctAnswer,
  });

  final String explanation;
  final bool isCorrect;
  final int correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCorrect ? Color(0xFFCFF5DE) : Color(0xFFFFCECE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isCorrect ? Icons.check_circle : Icons.cancel),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'ĐÚNG' : 'SAI - Đáp án đúng là số ${correctAnswer + 1}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Giải thích:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            explanation,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}