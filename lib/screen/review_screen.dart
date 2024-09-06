
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/settings_provider.dart';
import '../theme.dart';
import '../widget/custom_card.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {

  void onWrongQuestionClick() {
    print('Câu trả lời sai');
    context.push('/learn/-4');
  }

  void onSavedQuestionClick() {
    print('Câu hỏi đã lưu');
    context.push('/learn/-2');
  }

  void onHardQuestionClick() {
    print('Câu hỏi khó');
    context.push('/learn/-3');
  }

  void onSignsClick() {
    print('Biển báo');
    context.push('/signs');
  }

  @override
  Widget build(BuildContext context) {
    final isVibration = ref.watch(settingsProvider).isVibration;
    final isDarkMode = ref.watch(settingsProvider).isDarkMode;
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
                    Text(
                        'Mẹo làm bài',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    CustomCard(
                        width: screenWidth,
                        minHeight: 120,
                        title: 'Các mẹo làm bài',
                        description: 'Xem lại những mẹo này để nhớ lâu hơn',
                        imageUrl: 'assets/images/place-holder.png',
                        // backgroundColor: const Color(0xFFD5F2D0),
                        // titleColor: const Color(0xFF1A6F50),
                        // descriptionColor: const Color(0xFF73A37E),
                        backgroundColor: isDarkMode
                            ? MaterialTheme.nenMeo.dark.colorContainer
                            : MaterialTheme.nenMeo.value,
                        titleColor: isDarkMode
                            ? MaterialTheme.nenMeo.dark.onColorContainer
                            : MaterialTheme.nenMeo.light.onColorContainer,
                        descriptionColor: isDarkMode
                            ? MaterialTheme.nenMeo.dark.onColorContainer
                            : MaterialTheme.nenMeo.light.onColorContainer,
                        isVibration: isVibration,
                        onTap: () {
                          print('Câu hỏi đã lưu');
                        }),
                    const SizedBox(height: 16),
                    Text(
                        'Cần chú ý',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    // chỗ này
                    CustomCard(
                        width: screenWidth,
                        minHeight: 120,
                        title: 'Câu hỏi đã lưu',
                        description: 'Những câu hỏi bạn đã đánh dấu trước đó.',
                        imageUrl: 'assets/images/place-holder.png',
                        // backgroundColor: const Color(0xFAE0FFFA),
                        // titleColor: const Color(0xFF00697F),
                        // descriptionColor: const Color(0xFF51A7BF),
                        backgroundColor: isDarkMode
                        ? MaterialTheme.nenTruyenThong.dark.colorContainer
                        : MaterialTheme.nenTruyenThong.value,
                        titleColor: isDarkMode
                        ? MaterialTheme.nenTruyenThong.dark.onColorContainer
                        : MaterialTheme.nenTruyenThong.light.onColorContainer,
                        descriptionColor: isDarkMode
                        ? MaterialTheme.nenTruyenThong.dark.onColorContainer
                        : MaterialTheme.nenTruyenThong.light.onColorContainer,
                        isVibration: isVibration,
                        onTap: onSavedQuestionClick),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                              width: screenWidth / 2 - 32,
                              minHeight: 120,
                              title: 'Câu sai',
                              imageUrl: 'assets/images/place-holder.png',
                              // backgroundColor: const Color(0xFFFFE8CA),
                              // titleColor: const Color(0xFFD15C28),
                              backgroundColor: isDarkMode
                                  ? MaterialTheme.nenCauSai.dark.colorContainer
                                  : MaterialTheme.nenCauSai.value,
                              titleColor: isDarkMode
                                  ? MaterialTheme.nenCauSai.dark.onColorContainer
                                  : MaterialTheme.nenCauSai.light.onColorContainer,
                              isVibration: isVibration,
                              onTap: onWrongQuestionClick),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomCard(
                              width: screenWidth / 2 - 32,
                              minHeight: 120,
                              title: 'Câu hỏi khó',
                              imageUrl: 'assets/images/place-holder.png',
                              // backgroundColor: const Color(0xFFFFCECE),
                              // titleColor: const Color(0xFFA71F2A),
                              backgroundColor: isDarkMode
                                  ? MaterialTheme.nenCauKho.dark.colorContainer
                                  : MaterialTheme.nenCauKho.value,
                              titleColor: isDarkMode
                                  ? MaterialTheme.nenCauKho.dark.onColorContainer
                                  : MaterialTheme.nenCauKho.light.onColorContainer,
                              isVibration: isVibration,
                              onTap: onHardQuestionClick),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                        // backgroundColor: const Color(0xFFBDFFE7),
                        // titleColor: const Color(0xFF012504),
                        // descriptionColor: Colors.black,
                        backgroundColor: isDarkMode
                            ? MaterialTheme.nenBienBao.dark.colorContainer
                            : MaterialTheme.nenBienBao.value,
                        titleColor: isDarkMode
                            ? MaterialTheme.nenBienBao.dark.onColorContainer
                            : MaterialTheme.nenBienBao.light.onColorContainer,
                        descriptionColor: isDarkMode
                            ? MaterialTheme.nenBienBao.dark.onColorContainer
                            : MaterialTheme.nenBienBao.light.onColorContainer,
                        isVibration: isVibration,
                        onTap: onSignsClick),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ));

}}