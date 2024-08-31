import 'dart:convert';

import '../widget/answer_item.dart';

class QuestionState {
  QuestionState({
    required this.isSaved,
    required this.answerState,
    this.wrongAnswer,
  });

  bool isSaved;
  AnswerState answerState;
  int? wrongAnswer;

  factory QuestionState.fromMap(Map<String, dynamic> map) {
    return QuestionState(
      isSaved: map['isSaved'] == 1,
      answerState: AnswerState.values[map['answerState']],
      wrongAnswer: map['wrongAnswer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSaved': isSaved ? 1 : 0,
      'answerState': answerState.index,
      'wrongAnswer': wrongAnswer,
    };
  }

  String toJson() => json.encode(toMap());
  factory QuestionState.fromJson(String source) => QuestionState.fromMap(json.decode(source));
}