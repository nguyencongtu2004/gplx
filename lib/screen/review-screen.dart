
import 'package:flutter/material.dart';

import '../widget/custom-card.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ảnh nền
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
                    const Text(
                        'Mẹo làm bài',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    CustomCard(
                        width: screenWidth,
                        minHeight: 120,
                        title: 'Các mẹo làm bài',
                        description: 'Xem lại những mẹo này để nhớ lâu hơn',
                        imageUrl: 'assets/images/place-holder.png',
                        backgroundColor: const Color(0xFFD5F2D0),
                        titleColor: const Color(0xFF1A6F50),
                        descriptionColor: const Color(0xFF73A37E),
                        onTap: () {
                          print('Câu hỏi đã lưu');
                        }),
                    const SizedBox(height: 16),
                    const Text(
                        'Cần chú ý',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    // chỗ này
                    CustomCard(
                        width: screenWidth,
                        minHeight: 120,
                        title: 'Câu hỏi đã lưu',
                        description: 'Những câu hỏi bạn đã đánh dấu trước đó.',
                        imageUrl: 'assets/images/place-holder.png',
                        backgroundColor: const Color(0xFAE0FFFA),
                        titleColor: const Color(0xFF00697F),
                        descriptionColor: const Color(0xFF51A7BF),
                        onTap: () {
                          print('Câu hỏi đã lưu');
                        }),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                              width: screenWidth / 2 - 32,
                              minHeight: 120,
                              title: 'Câu sai',
                              imageUrl: 'assets/images/place-holder.png',
                              backgroundColor: const Color(0xFFFFE8CA),
                              titleColor: const Color(0xFFD15C28),
                              onTap: () {
                                print('Câu trả lời sai');
                              }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomCard(
                              width: screenWidth / 2 - 32,
                              minHeight: 120,
                              title: 'Câu hỏi khó',
                              imageUrl: 'assets/images/place-holder.png',
                              backgroundColor: const Color(0xFFFFCECE),
                              titleColor: const Color(0xFFA71F2A),
                              onTap: () {
                                print('Câu hỏi khó');
                              }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    /*Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomCard(
                              width: screenWidth / 2,
                              minHeight: 120,
                              title: 'Câu hỏi khó',
                              imageUrl: 'assets/images/place-holder.png',
                              backgroundColor: const Color(0xFFFFCECE),
                              titleColor: const Color(0xFFA71F2A),
                              onTap: () {
                                print('Câu hỏi khó');
                              }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomCard(
                              width: screenWidth,
                              minHeight: 120,
                              title: 'Câu hỏi chưa trả lời',
                              description:
                              'Những câu hỏi bạn chưa trả lời trong bài thi.',
                              imageUrl: 'assets/images/place-holder.png',
                              backgroundColor: const Color(0xFFE0F8FF),
                              titleColor: const Color(0xFF005F6B),
                              onTap: () {
                                print('Câu hỏi chưa trả lời');
                              }),
                        ),
                      ],
                    ),*/
                    const Text(
                        'Biển báo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    CustomCard(
                        width: screenWidth,
                        minHeight: 120,
                        title: 'Biển báo',
                        description: 'Tra cứu những biển báo phổ biến.',
                        imageUrl: 'assets/images/place-holder.png',
                        backgroundColor: const Color(0xFFBDFFE7),
                        titleColor: const Color(0xFF012504),
                        descriptionColor: Colors.black,
                        onTap: () {
                          print('Biển báo');
                        }),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ));

}}