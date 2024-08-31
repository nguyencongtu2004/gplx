import 'dart:convert';

import 'package:gplx/model/question_state.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:gplx/widget/answer_item.dart';

class Test {
  Test({
    required this.id,
    required this.testNumber,
    required this.licenseClass,
    required this.questions,
    required this.testAnswerState,
});

  final String id;
  final int testNumber;
  final String licenseClass;
  final List<int> questions;
  final TestAnswerState testAnswerState;

  factory Test.fromMap(Map<String, dynamic> map) {
    final questionsString = map['questions'] as String;
    final questions = questionsString.split(';').map((e) => int.parse(e)).toList();
    final TestAnswerState testAnswerState;
    if (map['answerState'].toString().isEmpty) {
      testAnswerState = TestAnswerState(result: TestResult.notAnswered,);
    } else {
      testAnswerState = TestAnswerState.fromJson(map['answerState']);
    }

    return Test(
      id: map['id'],
      testNumber: map['testNumber'],
      licenseClass: map['licenseClass'],
      questions: questions,
      testAnswerState: testAnswerState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'testNumber': testNumber,
      'licenseClass': licenseClass,
      'questions': questions,
      'answerState': testAnswerState.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  Test copyWith({
    String? id,
    int? testNumber,
    String? licenseClass,
    List<int>? questions,
    TestAnswerState? testAnswerState,
  }) {
    return Test(
      id: id ?? this.id,
      testNumber: testNumber ?? this.testNumber,
      licenseClass: licenseClass ?? this.licenseClass,
      questions: questions ?? this.questions,
      testAnswerState: testAnswerState ?? this.testAnswerState,
    );
  }
}