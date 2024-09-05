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
    // Xác định màu nền dựa trên trạng thái của câu trả lời
    final backgroundColor = switch (answerState) {
      AnswerState.correct => const Color(0xFFCFF5DE), // Màu xanh cho đúng
      AnswerState.wrong => const Color(0xFFFFCECE),   // Màu đỏ cho sai
      AnswerState.none => const Color(0xFFFFEA9D), // Màu vàng cho chưa trả lời
      _ => Colors.transparent,
    };

    // Xác định nội dung của thông báo
    final message = switch (answerState) {
      AnswerState.correct => 'ĐÚNG',
      AnswerState.wrong => 'SAI - Đáp án đúng là số $correctAnswer',
      AnswerState.none => 'CHƯA CHỌN CÂU TRẢ LỜI',
      _ => '',
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                answerState == AnswerState.correct
                    ? Icons.check_circle
                    : answerState == AnswerState.wrong
                    ? Icons.cancel
                    : Icons.warning,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (answerState != AnswerState.notAnswered) ...[
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
          ]
        ],
      ),
    );
  }
}