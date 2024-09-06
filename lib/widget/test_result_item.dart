import 'package:flutter/material.dart';
import 'package:gplx/model/test_answer_state.dart';
import 'package:lottie/lottie.dart';

class TestResultItem extends StatelessWidget {
  const TestResultItem({
    super.key,
    required this.testResult,
    required this.onTestAgain,
    required this.correctCount,
    required this.wrongCount,
    required this.notAnsweredCount,
  });

  final TestResult testResult;
  final void Function() onTestAgain;
  final int correctCount;
  final int wrongCount;
  final int notAnsweredCount;

  @override
  Widget build(BuildContext context) {
    final String assetPath;
    final String message;
    switch (testResult) {
      case TestResult.passed:
        assetPath = 'assets/animations/pass.json';
        message = 'Chúc mừng! Bạn đã thi đạt';
      case TestResult.failed:
        assetPath = 'assets/animations/fail2.json';
        message = 'Bạn đã thi trượt';
      case TestResult.failedWithFallingPoints:
        assetPath = 'assets/animations/fail2.json';
        message = 'Bạn đã thi trượt vì câu điểm liệt';
      default:
        throw Exception('Kết quả không hợp lệ');
    }

    return Center(
      child: Row(
        children: [
          LottieBuilder.asset(
            assetPath,
            filterQuality: FilterQuality.high,
            frameRate: FrameRate.max,
            fit: BoxFit.cover,
            height: 100,
            repeat: false,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.check),
                        Text('$correctCount'),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.close),
                        Text('$wrongCount'),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.help),
                        Text('$notAnsweredCount'),
                      ],)
                  ],
                ),
                ElevatedButton(
                  onPressed: onTestAgain,
                  child: const Text('Thi lại'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
