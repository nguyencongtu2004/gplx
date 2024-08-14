import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/explanation_item.dart';
import 'package:vibration/vibration.dart';

import '../model/question_state.dart';
import '../provider/question_provider.dart';

class QuestionAnswer extends ConsumerStatefulWidget {
  const QuestionAnswer({
    super.key,
    required this.currentQuestion,
    required this.totalQuestion,
    required this.currentQuestionIndex,
    required this.questionState,
    required this.onStateChanged,
  });

  final Question currentQuestion;
  final int totalQuestion;
  final int currentQuestionIndex;
  final QuestionState questionState;
  final ValueChanged<QuestionState> onStateChanged;

  @override
  ConsumerState<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends ConsumerState<QuestionAnswer> {
  late QuestionState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.questionState;
  }

  void updateState(QuestionState newState) {
    setState(() {
      _currentState = newState;
    });
    widget.onStateChanged(newState); // Notify the parent widget or any listeners
  }


  Future<void> onAnswer(int answeredIndex) async {
    if (_currentState.answerState != AnswerState.none) {
      return;
    }
    final isCorrect = answeredIndex == widget.currentQuestion.correctAnswer - 1;
    _currentState.answerState = isCorrect ? AnswerState.correct : AnswerState.wrong;
    _currentState.wrongAnswer = isCorrect ? -1 : answeredIndex;

    await ref.read(questionProvider.notifier).questionStatusChange(
        widget.currentQuestion.id,
        _currentState.answerState == AnswerState.correct
            ? QuestionStatus.correct
            : QuestionStatus.wrong);

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 15);
    }

    // Cập nhật trạng thái của câu trả lời
    updateState(_currentState);
  }

  Future<void> onSaved() async {
    await ref
        .read(questionProvider.notifier)
        .questionSavedChange(widget.currentQuestion.id);
    _currentState.isSaved = !_currentState.isSaved;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 15);
    }

    // Cập nhật trạng thái của câu trả lời
    updateState(_currentState);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.currentQuestion;
    final totalQuestion = widget.totalQuestion;
    final currentQuestionIndex = widget.currentQuestionIndex;

    AnswerState getAnswerState(int index) {
      if (_currentState.answerState == AnswerState.none) {
        return AnswerState.none;
      }
      if (index == widget.currentQuestion.correctAnswer - 1) {
        return AnswerState.correct;
      }
      if (index == _currentState.wrongAnswer) {
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (currentQuestion.isFailingPoint) ...[
                        const Icon(Icons.thunderstorm, color: Colors.red),
                        const SizedBox(width: 4)
                      ],
                      Text('Câu $currentQuestionIndex/$totalQuestion',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          )),
                      // TODO: fix không hiển thị trạng thái câu trả lời khi vào lại
                      if (_currentState.answerState == AnswerState.correct) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.check, color: Colors.green),
                      ],
                      if (_currentState.answerState == AnswerState.wrong) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.close, color: Colors.red),
                      ],
                    ],
                  ),
                ),
                IconButton(
                    onPressed: onSaved,
                    icon: Icon(
                      _currentState.isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color:
                          _currentState.isSaved ? Colors.green : Colors.black,
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
          if (currentQuestion.image.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/data/images_of_question/${currentQuestion.id}.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
          if (_currentState.answerState != AnswerState.none) ...[
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
                answerState: _currentState.answerState,
                explanation: currentQuestion.explanation,
                correctAnswer: currentQuestion.correctAnswer,
              ),
            ),
          ],
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
