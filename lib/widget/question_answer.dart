import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/question.dart';
import 'package:gplx/model/sign.dart';
import 'package:gplx/screen/signs_screen.dart';
import 'package:gplx/widget/answer_item.dart';
import 'package:gplx/widget/explanation_item.dart';
import 'package:gplx/widget/sign_item.dart';
import 'package:vibration/vibration.dart';

import '../model/question_state.dart';
import '../provider/question_provider.dart';
import '../provider/settings_provider.dart';
import '../provider/sign_provider.dart';

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
  late bool isVibration;
  final List<Sign> signs = [];

  @override
  void initState() {
    super.initState();
    _currentState = widget.questionState;

    print(widget.currentQuestion.signId);
    final signsFromProvider = ref.read(signProvider);

    for (final String signId in widget.currentQuestion.signId) {
      try {
        final sign =
            signsFromProvider.firstWhere((element) => element.id == signId);
        signs.add(sign);
      } catch (e) {
        print('Sign with id $signId not found');
        Vibration.vibrate(duration: 1000);
      }
    }

    isVibration = ref.read(settingsProvider).isVibration;
  }

  void updateState(QuestionState newState) {
    setState(() {
      _currentState = newState;
    });
    // Thông báo cho widget cha biết trạng thái mới của widget
    widget.onStateChanged(newState);
  }

  Future<void> onAnswer(int answeredIndex) async {
    if (_currentState.answerState != AnswerState.none) {
      return;
    }
    final isCorrect = answeredIndex == widget.currentQuestion.correctAnswer - 1;
    _currentState.answerState =
        isCorrect ? AnswerState.correct : AnswerState.wrong;
    _currentState.wrongAnswer = isCorrect ? -1 : answeredIndex;

    await ref.read(questionProvider.notifier).questionStatusChange(
        widget.currentQuestion.id,
        _currentState.answerState == AnswerState.correct
            ? QuestionStatus.correct
            : QuestionStatus.wrong);

    if (isVibration && (await Vibration.hasVibrator() ?? false)) {
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

    if (isVibration && (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate(duration: 15);
    }

    // Cập nhật trạng thái của câu trả lời
    updateState(_currentState);
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild QuestionAnswer');
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
                      if (currentQuestion.questionStatus ==
                          QuestionStatus.correct) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.check, color: Colors.green),
                      ] else if (currentQuestion.questionStatus ==
                          QuestionStatus.wrong) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.close, color: Colors.red),
                      ],
                    ],
                  ),
                ),
                IconButton(
                    onPressed: onSaved,
                    tooltip: _currentState.isSaved
                        ? 'Bỏ lưu câu hỏi'
                        : 'Lưu câu hỏi',
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
                  answer: '${answeredIndex + 1}- $answer',
                  answerState: getAnswerState(answeredIndex),
                  onTap: () {
                    onAnswer(answeredIndex);
                  });
            }).toList(),
          ),
          // Giải thích
          if (_currentState.answerState != AnswerState.none)
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ExplanationItem(
                      answerState: _currentState.answerState,
                      explanation: currentQuestion.explanation,
                      correctAnswer: currentQuestion.correctAnswer,
                    ),
                  ),
                  if (currentQuestion.signId.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Tra cứu biển báo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Tra cứu biển báo
                    Column(
                      children: [
                        for (final sign in signs)
                          SignItem(
                              sign: sign,
                              size: 90,
                              onTap: () => SignsScreen.onSignTap(context, sign,
                                  isVibration: isVibration)),
                      ],
                    ),
                  ],
                ].animate(interval: 50.ms).fadeIn(duration: 200.ms)),
          const SizedBox(height: 50 + 16),
        ],
      ),
    );
  }
}
