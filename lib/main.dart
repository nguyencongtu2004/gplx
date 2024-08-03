import 'package:flutter/material.dart';
import 'package:gplx/screen/home-screen.dart';

void main() {
  runApp(const GPLXApp());
}
class GPLXApp extends StatelessWidget {
  const GPLXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}