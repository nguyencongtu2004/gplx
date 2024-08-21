import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/license_class_provider.dart';

class TestListScreen extends ConsumerWidget {
  const TestListScreen({super.key});

  Widget _buildTestItem({required Center child, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
    context.push('/test-info/${index + 1}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String licenseClass = ref.read(licenseClassProvider);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Thi thử - Hạng $licenseClass',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
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
              child: Center(
                child: Text('${index + 1}'),
              ),
              onTap: () => onTestClick(context, ref, index));
        },
      ),
    );
  }
}
