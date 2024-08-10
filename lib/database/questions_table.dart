import 'package:gplx/database/database_service.dart';

// File này định nghĩa các hàm thao tác với bảng questions
class QuestionsTable {
  // Hàm lấy tất cả câu hỏi
  static Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await DatabaseService().database;
    return db!.query('questions');
  }

  // Hàm lấy câu hỏi theo id
  static Future<Map<String, dynamic>> getQuestionById(int id) async {
    final db = await DatabaseService().database;
    final data = await db!.query('questions', where: 'id = ?', whereArgs: [id]);
    return data[0];
  }

  // Hàm lấy câu hỏi theo chapter
  static Future<List<Map<String, dynamic>>> getQuestionsByChapter(int chapter) async {
    final db = await DatabaseService().database;
    return db!.query('questions', where: 'chapter = ?', whereArgs: [chapter]);
  }

  // Hàm lấy câu hỏi theo chapter và điểm liệt
  static Future<List<Map<String, dynamic>>> getFailingPointQuestionsByChapter(int chapter) async {
    final db = await DatabaseService().database;
    return db!.query('questions', where: 'chapter = ? AND isFailingPoint = 1', whereArgs: [chapter]);
  }

  // Hàm lấy số lượng câu hỏi theo chapter
  static Future<int> getQuestionCountByChapter(int chapter) async {
    final db = await DatabaseService().database;
    final data = await db!.query('questions', where: 'chapter = ?', whereArgs: [chapter]);
    return data.length;
  }
}