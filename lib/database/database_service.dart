import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:csv/csv.dart';

class DatabaseService {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDatabase();
    return _database;
  }

  Future<String> get fullPath async {
    const name = 'gplx.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initializeDatabase() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tạo bảng questions và signs
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY,
        question TEXT,
        answer1 TEXT,
        answer2 TEXT,
        answer3 TEXT,
        answer4 TEXT,
        correctAnswer INTEGER,
        explanation TEXT,
        signId TEXT,
        image TEXT,
        chapter INTEGER,
        isFailingPoint INTEGER,
        otomotoExplanation TEXT,
        isHard INTEGER,
        isSaved INTEGER,
        questionStatus INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE signs (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        image TEXT,
        category INTEGER
      )
    ''');

    // Nhập dữ liệu từ CSV
    await _importCSVtoTable(db, 'assets/data/questions.csv', 'questions');
    await _importCSVtoTable(db, 'assets/data/signs.csv', 'signs');
  }

  Future<void> _importCSVtoTable(Database db, String csvPath, String tableName) async {
    // Đọc file CSV
    final csvString = await rootBundle.loadString(csvPath);
    final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

    // Xác định tên cột cho bảng
    List<String> columns = csvData[0].map((column) => column.toString()).toList();

    // Lặp qua các hàng trong file CSV và chèn vào bảng
    for (int i = 1; i < csvData.length; i++) {
      Map<String, dynamic> row = {};
      for (int j = 0; j < columns.length; j++) {
        row[columns[j]] = csvData[i][j];
      }
      await db.insert(tableName, row, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    print('Imported $tableName');
  }
}

