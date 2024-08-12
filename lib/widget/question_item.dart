import 'package:flutter/material.dart';
import 'package:gplx/model/question.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.question,
    required this.index,
    required this.onTap,
  });

  final Question question;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
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
    );
  }
}