import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/model/test_answer_state.dart';

import '../model/test.dart';
import '../provider/license_class_provider.dart';
import '../provider/tests_provider.dart';

class TestListScreen extends ConsumerStatefulWidget {
  const TestListScreen({super.key});

  @override
  ConsumerState<TestListScreen> createState() => _TestListScreenState();
}

class _TestListScreenState extends ConsumerState<TestListScreen> {
  late final String licenseClass;

  @override
  void initState() {
    super.initState();
    licenseClass = ref.read(licenseClassProvider);
  }

  Widget _buildTestItem(BuildContext context, WidgetRef ref, Test test) {
    final backgroundColor = switch (test.testAnswerState.result) {
      TestResult.notAnswered => Colors.grey,
      TestResult.passed => Colors.green,
      _ => Colors.red,
    };
    final color = Theme.of(context).colorScheme.onSecondary;
    return GestureDetector(
      onTap: () => onTestClick(context, ref, test),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: test.testAnswerState.result == TestResult.notAnswered
            ? Center(
          child: Text('Đề ${test.testNumber}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              )),
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  test.testAnswerState.result == TestResult.passed
                      ? 'ĐẬU'
                      : 'RỚT',
                  style:
                  Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: color,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: color,
                  ),
                  Text('${test.testAnswerState.correctAnswers}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        color: color,
                      )),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.close,
                    color: color,
                  ),
                  Text('${test.testAnswerState.incorrectAnswers}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        color: color,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTestClick(BuildContext context, WidgetRef ref, Test test) {
    print('Test number clicked: ${test.testNumber}');
    final testId = test.id;
    final isAnswered = ref
        .read(testProvider)
        .firstWhere((t) => t.id == testId)
        .testAnswerState
        .result !=
        TestResult.notAnswered;
    if (isAnswered) {
      context.push('/test-result/$testId');
    } else {
      context.push('/test-info/$testId');
    }
  }

  void onRandomTestClick(BuildContext context, WidgetRef ref) {
    print('Random test clicked');
    context.push('/test-info/-1');
  }

  @override
  Widget build(BuildContext context) {
    final allTests = ref.watch(testProvider);
    final testIds = allTests
        .where((test) => test.licenseClass == licenseClass)
        .map((test) => test.id)
        .toList();
    print('TestListScreen: $testIds');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Thi thử - Hạng $licenseClass',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.list,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: GestureDetector(
              onTap: () => onRandomTestClick(context, ref),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đề thi ngẫu nhiên',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Chọn ra ngẫu nhiên các câu hỏi để thi',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: testIds.length,
            itemBuilder: (context, index) {
              final test = allTests.firstWhere((t) => t.id == testIds[index]);
              return _buildTestItem(context, ref, test);
            },
          ),
        ],
      ),
    );
  }
}
