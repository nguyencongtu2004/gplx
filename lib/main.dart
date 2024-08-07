import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gplx/navigation.dart';

void main() {
  // Đặt hướng sáng cho ứng dụng
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const GPLXApp());
}

class GPLXApp extends StatelessWidget {
  const GPLXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      //theme: gì đó,
    );
  }
}
