import 'package:gplx/database/database_service.dart';

import '../model/question.dart';

// File này định nghĩa các hàm thao tác với bảng questions
class QuestionsTable {
  // Hàm lấy tất cả câu hỏi
  static Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await DatabaseService().database;
    return db!.query('questions');
  }

  // Hàm cập nhật trạng thái lưu của câu hỏi
  static Future<void> updateQuestionSaved(int questionId, bool isSaved) async {
    final db = await DatabaseService().database;
    await db!.update(
      'questions',
      {'isSaved': isSaved ? 1 : 0},
      where: 'id = ?',
      whereArgs: [questionId],
    );
    print('Updated question $questionId saved to $isSaved');
  }

  // Hàm cập nhật trạng thái của câu hỏi
  static Future<void> updateQuestionStatus(int questionId, QuestionStatus status) async {
    final int statusValue;
    switch (status) {
      case QuestionStatus.notAnswered:
        statusValue = 0;
        break;
      case QuestionStatus.correct:
        statusValue = 1;
        break;
      case QuestionStatus.wrong:
        statusValue = -1;
        break;
      default:
        statusValue = 0;
    }

    final db = await DatabaseService().database;
    await db!.update(
      'questions',
      {'questionStatus': statusValue},
      where: 'id = ?',
      whereArgs: [questionId],
    );
    print('Updated question $questionId status to $status');
  }

}