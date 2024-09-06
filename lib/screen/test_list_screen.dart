import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/model/test_answer_state.dart';

import '../provider/license_class_provider.dart';
import '../provider/tests_provider.dart';

class TestListScreen extends ConsumerWidget {
  const TestListScreen({super.key});

  Widget _buildTestItem(
      BuildContext context,
      {required Center child, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
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
        child: child,
      ),
    );
  }

  void onTestClick(BuildContext context, WidgetRef ref, int index) {
    print('Test $index');
    final String licenseClass = ref.read(licenseClassProvider);
    final testId = ref
        .read(testProvider)
        .firstWhere((test) =>
            test.testNumber == index + 1 && test.licenseClass == licenseClass)
        .id;
    final isAnswered = ref
            .read(testProvider)
            .firstWhere((test) => test.id == testId)
            .testAnswerState
            .result !=
        TestResult.notAnswered;
    if (isAnswered) {
      context.push('/test-result/$testId');
    } else {
      // todo: thay vì push thì sẽ hiển thị trong đây luôn
      context.push('/test-info/$testId');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String licenseClass = ref.read(licenseClassProvider);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Thi thử - Hạng $licenseClass',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buildTestItem(
            context,
              child: Center(
                child: Text('${index + 1}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
              ),
              onTap: () => onTestClick(context, ref, index));
        },
      ),
    );
  }
}
