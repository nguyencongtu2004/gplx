import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({
    super.key,
    required this.testNumber,
  });

  final int testNumber;

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text('Test Screen $testNumber'),
      ),
    );
  }
}