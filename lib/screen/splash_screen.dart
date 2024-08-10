import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/question_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await ref.read(questionProvider.notifier).loadQuestions();
      if (ref.read(questionProvider).isEmpty) {
        print('Không có dữ liệu câu hỏi');
        return;
      }
      print('Dữ liệu câu hỏi đã được tải');
      // Chuyển hướng tới màn hình chính
        context.pushReplacement('/home');
    } catch (e) {
      print('Error loading data: $e');
      // Có thể hiển thị một thông báo lỗi hoặc thử tải lại dữ liệu
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
