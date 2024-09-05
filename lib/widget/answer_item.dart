import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import gói animate

enum AnswerState { none, notAnswered, answered, correct, wrong }

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
    // Xác định màu nền dựa vào trạng thái câu trả lời
    final Color backgroundColor = switch (answerState) {
      AnswerState.none => Colors.transparent,
      AnswerState.correct => const Color(0x5900DB57),
      AnswerState.wrong => const Color(0x8CFF1D1D),
      AnswerState.notAnswered => const Color(0x59FFD94C),
      AnswerState.answered => Colors.transparent,
    };

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 300.ms,
        // Thời gian của hiệu ứng
        curve: Curves.easeInOut,
        // Đường cong chuyển động
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        color: backgroundColor,
        // Màu nền có hiệu ứng animate
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
                  color: Colors.black,
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
