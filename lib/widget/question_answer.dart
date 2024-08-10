import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/provider/question_provider.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/explanation_item.dart';
import 'package:gplx/database/questions_table.dart';

class QuestionAnswer extends ConsumerStatefulWidget {
  const QuestionAnswer({
    super.key,
    required this.chapter,
  });

  final int chapter;

  @override
  ConsumerState<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends ConsumerState<QuestionAnswer> {
  late final Question currentQuestion;
  late final List<Question> allQuestions;

  late final int totalQuestion;
  var currentShowIndex = 0;
  var isSaved = false;
  var isCorrect = false;

  @override
  void initState() {
    super.initState();
    allQuestions = ref.read(questionProvider).where((question) => question.chapter == widget.chapter).toList();

    totalQuestion = allQuestions.length;
    print('Tổng số câu hỏi: $totalQuestion');
    setState(() {
      currentQuestion = allQuestions[currentShowIndex];
    });
  }

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
                      Text('Câu ${currentQuestion.id}?/$totalQuestion',
                          style: const TextStyle(
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
              currentQuestion.question,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
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
            children: currentQuestion.answers
                //.where((answer) => answer.isNotEmpty)
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
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
              explanation: currentQuestion.explanation,
              correctAnswer: currentQuestion.correctAnswer,
            ),
          ),
        ],
      ),
    );
  }
}
