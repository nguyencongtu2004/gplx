import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/license_class_provider.dart';

class TestInfoScreen extends ConsumerWidget {
  const TestInfoScreen({
    super.key,
    required this.testNumber,
  });

  final int testNumber;
  final int testTime = 30;
  final int totalQuestion = 30;
  final int minCorrect = 26;

  void onTestClick(BuildContext context, WidgetRef ref) {
    final licenseClass = ref.read(licenseClassProvider);
    context.pushReplacement('/test/$licenseClass/$testNumber');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String licenseClass = ref.read(licenseClassProvider);
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {},
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
          onPressed: () => onTestClick(context, ref),
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
            Text('Bài thi số $testNumber',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 36),
            const Center(
              child: Text('Thông tin bài thi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  'Tổng số câu hỏi: $totalQuestion'
                  '\nThời gian làm bài: $testTime phút'
                  '\nSố câu đúng tối thiểu: $minCorrect/$totalQuestion câu'
                  '\nKhi làm sai bất lỳ câu điểm liệt nào, thí sinh sẽ bị trượt.',
                  style: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
