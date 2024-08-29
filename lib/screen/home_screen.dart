import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/provider/question_provider.dart';
import 'package:gplx/widget/custom_card.dart';
import 'package:gplx/widget/topic.dart';
import 'package:vibration/vibration.dart';

import '../model/question.dart';
import '../provider/settings_provider.dart';
import '../provider/topic_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var isShowTopic = true;

  void onTestClick() {
    print('Thi thử');
    context.push('/test-list');
  }

  void onTopicClick(int index) {
    print('Học theo chủ đề');
    context.push('/learn/$index').then((value) {
      // cập nhật tiến trình của chủ đề khi quay lại
      setState(() {});
    });
  }

  void onAllQuestionClick() {
    print('Tất cả câu hỏi');
    context.push('/learn/-1').then((value) {
      // cập nhật tiến trình của chủ đề khi quay lại
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('HomeScreen build');
    final isVibration = ref.watch(settingsProvider).isVibration;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 250,
                  child: Image.asset(
                    'assets/images/home-image.jpg',
                    height: 250,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Kiểm tra',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                CustomCard(
                    width: screenWidth,
                    minHeight: 120,
                    title: 'Thi thử',
                    description: 'Sau bao ngày khổ luyện, đến lúc thử sức rồi.',
                    imageUrl: 'assets/images/place-holder.png',
                    backgroundColor: const Color(0xFFC2FDCB),
                    titleColor: const Color(0xFF012504),
                    isVibration: isVibration,
                    onTap: onTestClick),
                const SizedBox(height: 16),
                const Text('Chọn phương pháp học',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                CustomCard(
                    width: screenWidth,
                    minHeight: 120,
                    title: 'Lặp lại cách quãng',
                    description:
                        'Dựa trên việc lặp lại thông tin đã học theo khoảng cách ngày càng tăng.',
                    imageUrl: 'assets/images/place-holder.png',
                    backgroundColor: const Color(0xFFBEFFFF),
                    titleColor: const Color(0xFF010925),
                    isVibration: isVibration,
                    onTap: () {
                      print('Lặp lại cách quãng');
                    }),
                const SizedBox(height: 16),
                CustomCard(
                    width: screenWidth,
                    minHeight: 120,
                    title: 'Truyền thống ',
                    description: 'Hệ thống câu hỏi theo từng chủ đề.',
                    imageUrl: 'assets/images/place-holder.png',
                    backgroundColor: const Color(0xFFBEFFE7),
                    titleColor: const Color(0xFF011D26),
                    isVibration: isVibration,
                    onTap: onAllQuestionClick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            if (isVibration && (await Vibration.hasVibrator() ?? false)) {
                              Vibration.vibrate(duration: 20);
                            }
                            onAllQuestionClick();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF011D26),
                            backgroundColor: const Color(0xFF73F6B7),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Tất cả câu hỏi'),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                        if (isShowTopic == false)
                          ElevatedButton(
                            onPressed: () async {
                              if (isVibration && (await Vibration.hasVibrator() ?? false)) {
                                Vibration.vibrate(duration: 20);
                              }
                              print('Học theo chủ đề');
                              setState(() {
                                isShowTopic = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF011D26),
                              backgroundColor: const Color(0xFF73F6B7),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Học theo chủ đề'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        if (isShowTopic) ...[
                          const SizedBox(height: 8),
                          const Text(
                            'Các chủ đề',
                            style: TextStyle(
                              color: Color(0xFF011D26),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          for (int i = 0; i <= 7; i++)
                            TopicItem(
                              // todo: fix không cập nhật khi thay đổi dữ liệu
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              title: kTopic[i]!,
                              imageUrl: 'assets/images/place-holder.png',
                              progress: ref.read(questionProvider.notifier).getProgressByTopic(i),
                              correctQuestion: ref.read(questionProvider.notifier).getCorrectQuestionByTopic(i),
                              wrongQuestion: ref.read(questionProvider.notifier).getWrongQuestionByTopic(i),
                              learnedQuestion: ref.read(questionProvider.notifier).getAnsweredQuestionByTopic(i),
                              totalQuestion: ref.read(questionProvider.notifier).getTotalQuestionByTopic(i),
                              backgroundColor: const Color(0xFF99F4C5),
                              titleColor: const Color(0xFF121212),
                              progressColor: const Color(0xFF0A6F4E),
                              backgroundProgressColor: const Color(0xFF59D3AE),
                              isVibration: isVibration,
                              onTap: () {
                                onTopicClick(i);
                              },
                            ),
                          const SizedBox(height: 8),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (isVibration && (await Vibration.hasVibrator() ?? false)) {
                                  Vibration.vibrate(duration: 20);
                                }
                                print('Ẩn chủ đề');
                                setState(() {
                                  isShowTopic = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF011D26),
                                backgroundColor: const Color(0xFF73F6B7),
                              ),
                              child: const Text('Ẩn chủ đề'),
                            ),
                          ),
                        ]
                      ],
                    )),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
