import 'dart:convert';

import 'package:gplx/model/question_state.dart';

enum TestResult {
  pass,
  failWithNotAnswered,
  failWithIncorrect,
  failWithFallingPoints,
  notAnswered,
}

class TestAnswerState {
  TestAnswerState({
    required this.result,
    this.correctAnswers,
    this.incorrectAnswers,
    this.notAnswered,
    this.questionStates,
  });

  final TestResult result;
  final int? correctAnswers;
  final int? incorrectAnswers;
  final int? notAnswered;
  List<QuestionState>? questionStates;

  factory TestAnswerState.fromMap(Map<String, dynamic> map) {
    return TestAnswerState(
      result: TestResult.values[map['result']],
      correctAnswers: map['correctAnswers'],
      incorrectAnswers: map['incorrectAnswers'],
      notAnswered: map['notAnswered'],
      questionStates: List<QuestionState>.from(map['questionStates'].map((x) => QuestionState.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result.index,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'notAnswered': notAnswered,
      'questionStates': questionStates?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
  factory TestAnswerState.fromJson(String source) => TestAnswerState.fromMap(json.decode(source));
}