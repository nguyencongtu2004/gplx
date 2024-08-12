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
    final questionIndex = state.indexWhere((question) => question.id == questionId);
    final updatedQuestion = state[questionIndex].copyWith(isSaved: !state[questionIndex].isSaved);
    state[questionIndex] = updatedQuestion;

    await QuestionsTable.updateQuestionSaved(questionId, updatedQuestion.isSaved);
  }
}

final questionProvider =
    StateNotifierProvider<QuestionProvider, List<Question>>(
        (ref) => QuestionProvider());
