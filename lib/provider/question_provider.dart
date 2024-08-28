import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/database/questions_table.dart';
import 'package:gplx/model/question.dart';

class QuestionProvider extends StateNotifier<List<Question>> {
  QuestionProvider() : super([]);

  Future<void> loadQuestions() async {
    try {
      final questionsData = await QuestionsTable
          .getAllQuestions(); // Lấy tất cả dữ liệu từ bảng questions

      // Chuyển đổi dữ liệu thành danh sách các đối tượng Question
      List<Question> questions =
          questionsData.map((data) => Question.fromMap(data)).toList();

      // Cập nhật trạng thái của StateNotifier
      state = questions;
      print('Khởi tạo câu hỏi thành công từ DB');
    } catch (e) {
      // Xử lý lỗi (có thể log lỗi hoặc thông báo cho người dùng)
      print('Lỗi load câu hỏi từ DB: $e');
    }
  }

  Future<void> questionSavedChange(int questionId) async {
    final questionIndex =
        state.indexWhere((question) => question.id == questionId);
    final updatedQuestion =
        state[questionIndex].copyWith(isSaved: !state[questionIndex].isSaved);
    state[questionIndex] = updatedQuestion;

    await QuestionsTable.updateQuestionSaved(
        questionId, updatedQuestion.isSaved);
  }

  /*Future<void> questionStatusChange(
      int questionId, QuestionStatus status) async {
    final questionIndex =
        state.indexWhere((question) => question.id == questionId);
    final updatedQuestion =
        state[questionIndex].copyWith(questionStatus: status);
    state[questionIndex] = updatedQuestion;

    await QuestionsTable.updateQuestionStatus(questionId, status);
  }*/

  Future<void> questionStatusChange(int questionId, QuestionStatus status) async {
    final questionIndex = state.indexWhere((question) => question.id == questionId);
    final updatedQuestion = state[questionIndex].copyWith(questionStatus: status);

    // Cập nhật danh sách câu hỏi
    state = [
      ...state.sublist(0, questionIndex),
      updatedQuestion,
      ...state.sublist(questionIndex + 1),
    ];

    await QuestionsTable.updateQuestionStatus(questionId, status);
  }


  Future<void> resetQuestionsState() async {
    state = state
        .map((question) => question.copyWith(
            isSaved: false, questionStatus: QuestionStatus.notAnswered))
        .toList();
    await QuestionsTable.resetQuestions();
  }

  // hiển thị cho topic
  int getCorrectQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state
          .where((question) =>
              question.isFailingPoint &&
              question.questionStatus == QuestionStatus.correct)
          .length;
    } else {
      return state
          .where((question) =>
              question.chapter == chapter &&
              question.questionStatus == QuestionStatus.correct)
          .length;
    }
  }

  int getWrongQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state
          .where((question) =>
              question.isFailingPoint &&
              question.questionStatus == QuestionStatus.wrong)
          .length;
    } else {
      return state
          .where((question) =>
              question.chapter == chapter &&
              question.questionStatus == QuestionStatus.wrong)
          .length;
    }
  }

  int getSavedQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state
          .where((question) =>
              question.isFailingPoint && question.isSaved == true)
          .length;
    } else {
      return state
          .where((question) =>
              question.chapter == chapter && question.isSaved == true)
          .length;
    }
  }

  int getNotAnsweredQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state
          .where((question) =>
              question.isFailingPoint &&
              question.questionStatus == QuestionStatus.notAnswered)
          .length;
    } else {
      return state
          .where((question) =>
              question.chapter == chapter &&
              question.questionStatus == QuestionStatus.notAnswered)
          .length;
    }
  }

  int getAnsweredQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state
          .where((question) =>
              question.isFailingPoint &&
              question.questionStatus != QuestionStatus.notAnswered)
          .length;
    } else {
      return state
          .where((question) =>
              question.chapter == chapter &&
              question.questionStatus != QuestionStatus.notAnswered)
          .length;
    }
  }

  int getTotalQuestionByTopic(int chapter) {
    if (chapter == 0) {
      return state.where((question) => question.isFailingPoint).length;
    } else {
      return state.where((question) => question.chapter == chapter).length;
    }
  }

  double getProgressByTopic(int chapter) {
    final totalQuestion = getTotalQuestionByTopic(chapter);
    if (totalQuestion == 0) {
      return 0;
    }
    final answeredQuestion = getAnsweredQuestionByTopic(chapter);
    return answeredQuestion / totalQuestion;
  }
}

final questionProvider =
    StateNotifierProvider<QuestionProvider, List<Question>>(
        (ref) => QuestionProvider());
