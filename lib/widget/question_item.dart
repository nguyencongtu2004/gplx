import 'package:flutter/material.dart';
import 'package:gplx/model/question.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.question,
    required this.index,
    required this.onTap,
    required this.isSelecting,
  });

  final Question question;
  final int index;
  final bool isSelecting;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final MaterialColor questionNumberColor;
    if (question.questionStatus == QuestionStatus.correct) {
      questionNumberColor = Colors.green;
    } else if (question.questionStatus == QuestionStatus.wrong) {
      questionNumberColor = Colors.red;
    } else {
      questionNumberColor = Colors.grey;
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelecting ? Colors.yellow[200] : Colors.transparent,
        height: 64, // 64 + 16 (của padding) = 80 (kích thước của mỗi item)
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Số thứ tự câu hỏi
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: questionNumberColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Câu hỏi
              Expanded(
                child: Text(
                  question.question,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (question.image.isNotEmpty)
              ...[
                const SizedBox(width: 8),
                Image.asset(
                'assets/data/images_of_question/${question.id}.png',
                width: 70,
                fit: BoxFit.cover,
              )],
              if (question.isFailingPoint)
              ...[
                const SizedBox(width: 8),
                const Icon(Icons.thunderstorm, color: Colors.red),
              ],
            ],
          ),
        ),
      ),
    );
  }
}