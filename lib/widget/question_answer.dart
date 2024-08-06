import 'package:flutter/material.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/explanation_item.dart';

class QuestionAnswer extends StatelessWidget {
  QuestionAnswer({super.key});

  final int questionNumber = 1;
  final int totalQuestion = 60;
  final bool isSaved = false;
  final String question = 'Hành vi nào dưới đây bị nghiêm cấm?';
  final List<String> answers = [
    '1 - Đỗ xe trên hè phố',
    '2- Sử dụng xe đạp đi trên các tuyến quốc lộ có tốc độ cao',
    '3 - Làm hỏng (cố ý) cọc tiêu, gương cầu, dải phân cách',
    '4 - Sử dụng còi và quay đầu xe trong khu vực dân cư',
  ];
  final int correctAnswer = 2;
  final String explanation =
      'Hành vi phá hoại tài sản như cọc tiêu, gương cầu,... bị nghiêm cấm';

  final isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.thunderstorm),
                      SizedBox(width: 8),
                      Text('Câu $questionNumber/$totalQuestion',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon:
                        Icon(isSaved ? Icons.bookmark : Icons.bookmark_outline)),
              ],
            ),
          ),
          // Câu hỏi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              question,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(),
          ),
          // Câu trả lời
          Column(
            children: answers
                .map((answer) => AnswerItem(
                    answer: answer,
                    answerState: AnswerState.none,
                    onTap: () {
                      print('Chọn câu trả lời: $answer');
                    }))
                .toList(),
          ),
          // Giải thích
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Kết quả',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Giải thích
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ExplanationItem(
              isCorrect: isCorrect,
              explanation: explanation,
              correctAnswer: correctAnswer,
            ),
          ),
        ],
      ),
    );
  }
}
