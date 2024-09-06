import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/model/test_information.dart';
import 'package:gplx/provider/tests_provider.dart';

import '../provider/license_class_provider.dart';
import '../provider/settings_provider.dart';

class TestInfoScreen extends ConsumerWidget {
  const TestInfoScreen({
    super.key,
    required this.testId,
  });
  final String testId;

  int testNumber(WidgetRef ref) => ref.read(testProvider).firstWhere((test) => test.id == testId).testNumber;

  void onTestClick(BuildContext context) {
    context.pushReplacement('/test/$testId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String licenseClass = ref.read(licenseClassProvider);
    final TestInformation testInformation = ref.read(testProvider.notifier).getTestInformation(licenseClass);
    final isDarkMode = ref.watch(settingsProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            icon: const Icon(
              Icons.list,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () => onTestClick(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Bắt đầu thi'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text('Bài thi thử lý thuyết\nHạng $licenseClass',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Text('Bài thi số ${testNumber(ref)}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 36),
            Center(
              child: Text('Thông tin bài thi',
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  'Tổng số câu hỏi: ${testInformation.totalQuestions}'
                  '\nThời gian làm bài: ${testInformation.timeLimit} phút'
                  '\nSố câu đúng tối thiểu: ${testInformation.minimumPassingScore}/${testInformation.totalQuestions} câu'
                  '\nKhi làm sai bất lỳ câu điểm liệt nào, thí sinh sẽ bị trượt.',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
