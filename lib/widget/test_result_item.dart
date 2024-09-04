import 'package:flutter/material.dart';
import 'package:gplx/model/test_answer_state.dart';

class TestResultItem extends StatelessWidget {
  const TestResultItem({
    super.key,
    required this.testResult,
  });

  final TestResult testResult;

  Widget buildTestPassed() {
    return Column(
      children: [
        Text('Chúc mừng bạn đã vượt qua bài thi'),
      ],
    );
  }

  Widget buildTestFailed() {
    return Column(
      children: [
        Text('Rất tiếc, bạn đã không vượt qua bài thi'),
      ],
    );
  }

  Widget buildTestFailedWithFallingPoints() {
    return Column(
      children: [
        Text('Rất tiếc, bạn đã không vượt qua bài thi'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (testResult) {
      case TestResult.passed:
        return buildTestPassed();
      case TestResult.failed:
        return buildTestFailed();
      case TestResult.failedWithFallingPoints:
        return buildTestFailedWithFallingPoints();
      default:
        throw Exception('Kêt quả không hợp lệ');
    }
  }
}
