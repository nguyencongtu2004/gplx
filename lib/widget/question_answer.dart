import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/explanation_item.dart';

class QuestionAnswer extends ConsumerStatefulWidget {
  const QuestionAnswer({
    super.key,
    required this.currentQuestion,
    required this.totalQuestion,
  });

  final Question currentQuestion;
  final int totalQuestion;

  @override
  ConsumerState<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends ConsumerState<QuestionAnswer> {
  var isSaved = false;
  var answerState = AnswerState.none;
  int? wrongAnswer;

  @override
  void initState() {
    super.initState();
  }

  void onAnswer(int answeredIndex) {
    if (answerState != AnswerState.none) {
      return;
    }
    final correctAnswerIndex = widget.currentQuestion.correctAnswer - 1;
    if (answeredIndex == correctAnswerIndex) {
      answerState = AnswerState.correct;
    } else {
      answerState = AnswerState.wrong;
      wrongAnswer = answeredIndex;
    }
    // Cập nhật trạng thái của câu trả lời
    setState(() {});
  }

  onSaved() {
    isSaved = !isSaved;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.currentQuestion;
    final totalQuestion = widget.totalQuestion;

    AnswerState getAnswerState(int index) {
      if (answerState == AnswerState.none) {
        return AnswerState.none;
      }
      if (index == widget.currentQuestion.correctAnswer - 1) {
        return AnswerState.correct;
      }
      if (index == wrongAnswer) {
        return AnswerState.wrong;
      }
      return AnswerState.none;
    }

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
                      const Icon(Icons.thunderstorm),
                      const SizedBox(width: 8),
                      Text('Câu ${currentQuestion.id}?/$totalQuestion',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: onSaved,
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_outline,
                      color: isSaved ? Colors.green : Colors.black,
                    )),
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
            children: currentQuestion.answers.map((answer) {
              final answeredIndex = currentQuestion.answers.indexOf(answer);
              return AnswerItem(
                  answer: answer,
                  answerState: getAnswerState(answeredIndex),
                  onTap: () {
                    onAnswer(answeredIndex);
                  });
            }).toList(),
          ),
          // Giải thích
          if (answerState != AnswerState.none) ...[
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
                answerState: answerState,
                explanation: currentQuestion.explanation,
                correctAnswer: currentQuestion.correctAnswer,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
