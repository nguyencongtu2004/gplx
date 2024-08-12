import 'package:gplx/database/database_service.dart';

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

}