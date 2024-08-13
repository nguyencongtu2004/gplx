import 'package:gplx/database/database_service.dart';

// File này định nghĩa các hàm thao tác với bảng signs
class SignsTable {
  // Hàm lấy tất cả biển báo
  static Future<List<Map<String, dynamic>>> getAllSigns() async {
    final db = await DatabaseService().database;
    return db!.query('signs');
  }

}