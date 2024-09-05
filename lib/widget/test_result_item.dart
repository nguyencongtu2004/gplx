import 'package:flutter/material.dart';
import 'package:gplx/model/test_answer_state.dart';

class TestResultItem extends StatelessWidget {
  const TestResultItem({
    super.key,
    required this.testResult,
    required this.onTestAgain,
  });

  final TestResult testResult;
  final void Function() onTestAgain;

  Widget buildTestPassed() {
    return Text('Chúc mừng bạn đã vượt qua bài thi');
  }

  Widget buildTestFailed() {
    return Text('Rất tiếc, bạn đã không vượt qua bài thi');
  }

  Widget buildTestFailedWithFallingPoints() {
    return Text('Rất tiếc, bạn đã không vượt qua bài thi');
  }

  @override
  Widget build(BuildContext context) {
    final Widget content;
    switch (testResult) {
      case TestResult.passed:
        content = buildTestPassed();
      case TestResult.failed:
        content = buildTestFailed();
      case TestResult.failedWithFallingPoints:
        content = buildTestFailedWithFallingPoints();
      default:
        throw Exception('Kêt quả không hợp lệ');
    }

    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content,
        ElevatedButton(
          onPressed: onTestAgain,
          child: const Text('Thi lại'),
        ),
      ],
    ));
  }
}
