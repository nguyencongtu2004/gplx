import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/provider/license_class_provider.dart';

import '../provider/question_provider.dart';
import '../provider/settings_provider.dart';
import '../provider/sign_provider.dart';

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
    } catch (e) {
      print('Lỗi load câu hỏi: $e');
      // Có thể hiển thị một thông báo lỗi hoặc thử tải lại dữ liệu
    }

    try {
      await ref.read(signProvider.notifier).loadSigns();
      if (ref.read(signProvider).isEmpty) {
        print('Không có dữ liệu biển báo');
        return;
      }
      print('Dữ liệu biển báo đã được tải');
    } catch (e) {
      print('Lỗi load biển báo: $e');
      // Có thể hiển thị một thông báo lỗi hoặc thử tải lại dữ liệu
    }

    try {
      // Tải dữ liệu cài đặt và hạng giấy phép lái xe
      await ref.read(settingsProvider.notifier).loadSettings();
      await ref.read(licenseClassProvider.notifier).loadLicenseClass();
      print('Dữ liệu cài đặt đã được tải');
    } catch (e) {
      print('Lỗi load cài đặt: $e');
      // Có thể hiển thị một thông báo lỗi hoặc thử tải lại dữ liệu
    }

    // Chuyển hướng tới màn hình chính
    context.pushReplacement('/home');
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
