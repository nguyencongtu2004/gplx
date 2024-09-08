import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:gplx/model/test_information.dart';

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

  Future<void> updateTestAnswerState(String testId, TestAnswerState testAnswerState) async {
    final test = state.firstWhere((test) => test.id == testId);
    final updatedTest = test.copyWith(testAnswerState: testAnswerState);
    final updatedTests = state.map((t) => t.id == testId ? updatedTest : t).toList();
    state = updatedTests;

    await TestsTable.updateTestAnswerState(testId, testAnswerState);
  }

  List<int> getFailingPointQuestionIds() {
    return [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 35, 36, 37, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 84, 91, 99, 101, 109, 112, 114, 118, 119, 143, 145, 147, 150, 153, 154, 161, 199, 200, 210, 211, 214, 221, 227, 231, 242, 245, 248, 258, 260, 261, 262];
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
      "A1": {
        "khai_niem": [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
        "diem_liet": [19, 20, 23, 24, 26, 37, 45, 46, 47, 48, 49, 50, 51, 52, 53, 109, 112, 150, 154, 162],
        "quy_tac": [19, 20, 23, 24, 26, 31, 32, 34, 37, 38, 39, 45, 46, 47, 48, 49, 50, 51, 52, 53, 55, 59, 60, 61, 72, 73, 74, 75, 81, 82, 83, 85, 86, 87, 88, 89, 92, 95, 96, 97, 98, 100, 104, 109, 110, 111, 112, 113, 115, 116, 117, 120, 122, 123, 140, 141, 144, 146, 150, 152, 157, 158, 159, 165, 166],
        "nghiep_vu": [],
        "toc_do": [124, 125, 126, 127],
        "van_hoa": [197, 203, 204, 207, 213],
        "ky_thuat": [214, 218, 219, 223, 250, 262, 263, 265, 266, 267, 268, 269],
        "cau_tao": [],
        "bien_bao": [309, 310, 311, 317, 318, 319, 321, 322, 326, 327, 328, 329, 330, 333, 334, 336, 337, 339, 352, 353, 354, 365, 371, 372, 373, 374, 375, 376, 377, 378, 379, 385, 386, 387, 388, 389, 391, 396, 397, 399, 400, 401, 402, 415, 416, 424, 436, 437, 438, 439, 440, 441, 442, 443, 454, 455, 456, 458, 462, 478, 479, 480, 481, 483, 486],
        "sa_hinh": [487, 490, 492, 495, 499, 503, 504, 505, 507, 508, 509, 510, 517, 520, 525, 527, 528, 529, 538, 539, 540, 543, 548, 556, 559, 560, 561, 562, 565, 567, 568, 572, 592, 596, 600],
      },
      "A2": {
        "khai_niem": [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
        "diem_liet": [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 35, 36, 37, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 84, 91, 99, 109, 112, 114, 118, 143, 145, 147, 150, 154, 199, 209, 210, 211, 214, 227, 248, 261, 262],
        "quy_tac": [17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 43, 44, 46, 47, 48, 49, 50, 51, 52, 54, 55, 56, 57, 58, 59, 60, 62, 63, 64, 65, 66, 67, 68, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 83, 84, 86, 87, 88, 89, 90, 91, 92, 94, 95, 96, 97, 98, 99, 100, 102, 103, 104, 105, 106, 107, 108, 110, 111, 112, 113, 114, 115, 116, 118, 119, 120, 121, 122, 123, 140, 142, 143, 144, 145, 146, 147, 148, 150, 151, 152, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 166],
        "nghiep_vu": [],
        "toc_do": [124, 126, 127, 128, 129, 130, 131, 132, 134, 135, 136, 137, 138, 139],
        "van_hoa": [197, 203, 204, 207, 213],
        "ky_thuat": [214, 218, 219, 223, 227, 241, 248, 249, 250, 261, 262, 263, 265, 266, 267, 268, 269],
        "cau_tao": [],
        "bien_bao": [305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486],
        "sa_hinh": [487, 490, 492, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 517, 520, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 538, 539, 540, 542, 543, 544, 545, 547, 548, 549, 350, 551, 553, 554, 556, 559, 560, 561, 562, 563, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 577, 582, 583, 584, 585, 587, 588, 589, 591, 592, 593, 594, 596, 600],
      },
      "A3": {
        "khai_niem": [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15],
        "diem_liet": [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 35, 36, 37, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 84, 91, 99, 101, 109, 112, 114, 118, 119, 143, 145, 147, 150, 153, 154, 161, 199, 209, 210, 211, 214, 227, 248, 261, 262],
        "quy_tac": [17, 18, 19, 20, 21, 22, 23, 25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 37, 38, 39, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 57, 58, 59, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 73, 74, 75, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 87, 89, 90, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 103, 105, 106, 107, 108, 109, 110, 111, 113, 114, 115, 116, 117, 118, 119, 121, 122, 123, 140, 141, 142, 143, 145, 146, 147, 148, 149, 150, 151, 153, 154, 155, 156, 157, 158, 159, 161, 162, 163, 164, 165, 166],
        "nghiep_vu": [],
        "toc_do": [124, 125, 126, 127, 129, 130, 131, 132, 133, 134, 135, 137, 138, 139],
        "van_hoa": [193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213],
        "ky_thuat": [214, 218, 219, 223, 227, 241, 248, 249, 250, 261, 262, 263, 265, 266, 267, 268, 269],
        "cau_tao": [],
        "bien_bao": chuong["chuong_6"]!,
        "sa_hinh": chuong["chuong_7"]!,
      },
      "A4": {
        "khai_niem": [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15],
        "diem_liet": [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 35, 36, 37, 40, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 84, 91, 99, 101, 109, 112, 114, 118, 119, 143, 145, 147, 150, 153, 154, 161, 199, 209, 210, 211, 214, 227, 248, 261, 262],
        "quy_tac": [17, 18, 19, 20, 21, 22, 23, 25, 26, 27, 28, 29, 30, 31, 33, 34, 35, 36, 37, 38, 39, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 57, 58, 59, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 73, 74, 75, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 87, 89, 90, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 103, 105, 106, 107, 108, 109, 110, 111, 113, 114, 115, 116, 117, 118, 119, 121, 122, 123, 140, 141, 142, 143, 145, 146, 147, 148, 149, 150, 151, 153, 154, 155, 156, 157, 158, 159, 161, 162, 163, 164, 165, 166],
        "nghiep_vu": [],
        "toc_do": [124, 125, 126, 127, 129, 130, 131, 132, 133, 134, 135, 137, 138, 139],
        "van_hoa": [193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213],
        "ky_thuat": [214, 218, 219, 223, 227, 241, 248, 249, 250, 261, 262, 263, 265, 266, 267, 268, 269],
        "cau_tao": [],
        "bien_bao": chuong["chuong_6"]!,
        "sa_hinh": chuong["chuong_7"]!,
      },
      "B1": {
        "khai_niem": List.generate(16, (index) => index + 1),
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
        "khai_niem": List.generate(16, (index) => index + 1),
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
      "C": {
        "khai_niem": List.generate(16, (index) => index + 1),
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
      "D": {
        "khai_niem": List.generate(16, (index) => index + 1),
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
      "E": {
        "khai_niem": List.generate(16, (index) => index + 1),
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
      "F": {
        "khai_niem": List.generate(16, (index) => index + 1),
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
    };

    Map<String, List<int>> questionDistribution = {
      "A1": [1, 1, 6, 0, 1, 1, 1, 0, 7, 7],  // 25 questions
      "A2": [1, 1, 6, 0, 1, 1, 1, 0, 7, 7],  // 25 questions
      "A3": [1, 1, 6, 0, 1, 1, 1, 0, 7, 7],  // 25 questions
      "A4": [1, 1, 6, 0, 1, 1, 1, 0, 7, 7],  // 25 questions
      "B1": [1, 1, 6, 0, 1, 1, 1, 1, 9, 9],  // 30 questions
      "B2": [1, 1, 7, 1, 1, 1, 2, 1, 10, 10],  // 35 questions
      "C": [1, 1, 7, 1, 1, 1, 2, 1, 14, 11],  // 40 questions
      "D": [1, 1, 7, 1, 1, 1, 2, 1, 16, 14],  // 45 questions
      "E": [1, 1, 7, 1, 1, 1, 2, 1, 16, 14],  // 45 questions
      "F": [1, 1, 7, 1, 1, 1, 2, 1, 16, 14],  // 45 questions
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

  TestInformation getTestInformation(String licenseClass) {
    final int totalQuestions;
    final int timeLimit; // in minutes
    final int minimumPassingScore;
    switch (licenseClass) {
      case "A1":
        totalQuestions = 25;
        timeLimit = 19;
        minimumPassingScore = 21;
        break;
      case "A2":
        totalQuestions = 25;
        timeLimit = 19;
        minimumPassingScore = 23;
        break;
      case "A3":
        totalQuestions = 25;
        timeLimit = 19;
        minimumPassingScore = 22;
        break;
      case "A4":
        totalQuestions = 25;
        timeLimit = 19;
        minimumPassingScore = 22;
        break;
      case "B1":
        totalQuestions = 30;
        timeLimit = 20;
        minimumPassingScore = 27;
        break;
      case "B2":
        totalQuestions = 35;
        timeLimit = 22;
        minimumPassingScore = 32;
        break;
      case "C":
        totalQuestions = 40;
        timeLimit = 24;
        minimumPassingScore = 36;
        break;
      case "D":
        totalQuestions = 45;
        timeLimit = 26;
        minimumPassingScore = 41;
        break;
      case "E":
        totalQuestions = 45;
        timeLimit = 26;
        minimumPassingScore = 42;
        break;
      case "F":
        totalQuestions = 45;
        timeLimit = 26;
        minimumPassingScore = 41;
        break;
      default:
        throw Exception('Invalid license class');
    }

    return TestInformation(
      totalQuestions: totalQuestions,
      timeLimit: timeLimit,
      minimumPassingScore: minimumPassingScore,);
  }

}

final testProvider =
    StateNotifierProvider<TestProvider, List<Test>>(
        (ref) => TestProvider());

TestAnswerState? kTestRandomAnswerState;
List<int>? kTestRandomIds;