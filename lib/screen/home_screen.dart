import 'package:flutter/material.dart';
import 'package:gplx/screen/learn_screen.dart';
import 'package:gplx/widget/custom_card.dart';
import 'package:gplx/widget/topic.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      print('Thi thử');
                    }),
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
                    vibration: false,
                    onTap: () {
                      print('Truyền thống');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            if (await Vibration.hasVibrator() ?? false) {
                              Vibration.vibrate(duration: 20);
                            }
                            print('Tất cả câu hỏi');
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
                        ElevatedButton(
                          onPressed: () async {
                            if (await Vibration.hasVibrator() ?? false) {
                            Vibration.vibrate(duration: 20);
                            }
                            print('Học theo chủ đề');
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
                        const SizedBox(height: 8),
                        Text(
                          'Các chủ đề',
                          style: TextStyle(
                            color: const Color(0xFF011D26),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (int i = 0; i < 6; i++)
                          Topic(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            title: 'Câu hỏi điểm liệt',
                            imageUrl: 'assets/images/place-holder.png',
                            progress: 0.5,
                            correctQuestion: 10,
                            wrongQuestion: 5,
                            learnedQuestion: 15,
                            totalQuestion: 60,
                            backgroundColor: const Color(0xFF99F4C5),
                            titleColor: const Color(0xFF121212),
                            progressColor: const Color(0xFF0A6F4E),
                            backgroundProgressColor: const Color(0xFF59D3AE),
                            onTap: () {
                              print('Câu hỏi điểm liệt');
                              // test
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LearnScreen()));

                            },
                          ),
                      ],
                    )),
                const SizedBox(height: 16),],
            ),
          ),
        ],
      ),
    ));
  }
}
