import 'package:gplx/database/database_service.dart';
import 'package:gplx/model/test.dart';
import 'package:gplx/model/test_answer_state.dart';

class TestsTable {
  static Future<List<Map<String, dynamic>>> getAllTests() async {
    final db = await DatabaseService().database;
    return db!.query('tests');
  }

  static Future<void> updateTestAnswerState(String testId, TestAnswerState testAnswerState) async {
    final db = await DatabaseService().database;
    await db!.update(
      'tests',
      {'answerState': testAnswerState.toJson()},
      where: 'id = ?',
      whereArgs: [testId],
    );
    print('Updated test $testId answerState to ${testAnswerState.result} and more');
    //print(testAnswerState.toMap());
  }


}