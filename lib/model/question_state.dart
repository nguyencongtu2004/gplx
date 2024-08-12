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
}