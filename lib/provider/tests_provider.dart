import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:gplx/widget/answer_item.dart';

import '../database/tests_table.dart';
import '../model/test.dart';

class TestProvider extends StateNotifier<List<Test>> {
  TestProvider() : super([]);

  Future<void> loadTests() async {
    try {
      final testsData = await TestsTable.getAllTests(); // Lấy tất cả dữ liệu từ bảng tests

      // Chuyển đổi dữ liệu thành danh sách các đối tượng Test
      List<Test> tests = testsData.map((data) => Test.fromMap(data)).toList();

      // Cập nhật trạng thái của StateNotifier
      state = tests;
      print('Khởi tạo đề thi thành công từ DB');
    } catch (e) {
      // Xử lý lỗi (có thể log lỗi hoặc thông báo cho người dùng)
      print('Lỗi load đề thi từ DB: $e');
    }
  }

  Future<void> updateTestAnswerState(int testNumber, String licenseClass, TestAnswerState testAnswerState) async {
    final test = state.firstWhere((test) => test.testNumber == testNumber && test.licenseClass == licenseClass);
    final updatedTest = test.copyWith(testAnswerState: testAnswerState);
    final updatedTests = state.map((t) => t.testNumber == testNumber && t.licenseClass == licenseClass ? updatedTest : t).toList();
    state = updatedTests;

    await TestsTable.updateTestAnswerState(updatedTest.id, testAnswerState);
  }

  List<int> generateTestSet(String licenseClass) {
    Map<String, List<int>> chuong = {
      "chuong_1": List.generate(166, (index) => index + 1),
      "chuong_2": List.generate(26, (index) => index + 167),
      "chuong_3": List.generate(21, (index) => index + 193),
      "chuong_4": List.generate(56, (index) => index + 214),
      "chuong_5": List.generate(35, (index) => index + 270),
      "chuong_6": List.generate(182, (index) => index + 305),
      "chuong_7": List.generate(114, (index) => index + 487),
      "chuong_8": [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 35, 36, 37, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 84, 91, 99, 101, 109, 112, 114, 118, 119, 143, 145, 147, 150, 153, 154, 161, 199, 200, 210, 211, 214, 221, 227, 231, 242, 245, 248, 258, 260, 261, 262],
    };

    Map<String, Map<String, List<int>>> licenseClasses = {
      "B1": {
        "khai_niem": chuong["chuong_1"]!.sublist(0, 16),
        "diem_liet": chuong["chuong_8"]!,
        "quy_tac": chuong["chuong_1"]!.sublist(16, 123) + chuong["chuong_1"]!.sublist(139, 166),
        "nghiep_vu": [],
        "toc_do": chuong["chuong_1"]!.sublist(123, 139),
        "van_hoa": chuong["chuong_3"]!,
        "ky_thuat": chuong["chuong_4"]!,
        "cau_tao": chuong["chuong_5"]!,
        "bien_bao": chuong["chuong_6"]!,
        "sa_hinh": chuong["chuong_7"]!,
      },
      "B2": {
        "khai_niem": chuong["chuong_1"]!.sublist(0, 16),
        "diem_liet": chuong["chuong_8"]!,
        "quy_tac": chuong["chuong_1"]!.sublist(16, 123) + chuong["chuong_1"]!.sublist(139, 166),
        "nghiep_vu": chuong["chuong_2"]!,
        "toc_do": chuong["chuong_1"]!.sublist(123, 139),
        "van_hoa": chuong["chuong_3"]!,
        "ky_thuat": chuong["chuong_4"]!,
        "cau_tao": chuong["chuong_5"]!,
        "bien_bao": chuong["chuong_6"]!,
        "sa_hinh": chuong["chuong_7"]!,
      },
      // Add other license classes in the same format...
    };

    Map<String, List<int>> questionDistribution = {
      "B1": [1, 1, 6, 0, 1, 1, 1, 1, 9, 9],  // 30 questions
      "B2": [1, 1, 7, 1, 1, 1, 2, 1, 10, 10],  // 35 questions

    };

    var random = Random();
    Map<String, List<int>> questionsMap = licenseClasses[licenseClass]!;
    List<int> distribution = questionDistribution[licenseClass]!;
    List<int> selectedQuestions = [];

    questionsMap.forEach((chapter, questions) {
      int count = distribution[questionsMap.keys.toList().indexOf(chapter)];
      if (count > 0) {
        Set<int> chosenQuestions = {};
        while (chosenQuestions.length < count) {
          int question = questions[random.nextInt(questions.length)];
          if (!chosenQuestions.contains(question)) {
            chosenQuestions.add(question);
          }
        }
        selectedQuestions.addAll(chosenQuestions);
      }
    });

    selectedQuestions.sort();
    return selectedQuestions;
  }

}

final testProvider =
    StateNotifierProvider<TestProvider, List<Test>>(
        (ref) => TestProvider());