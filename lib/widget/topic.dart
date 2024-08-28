import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Topic extends StatelessWidget {
  const Topic({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.progress,
    required this.learnedQuestion,
    required this.totalQuestion,
    required this.correctQuestion,
    required this.wrongQuestion,
    this.padding = const EdgeInsets.all(0),
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.backgroundProgressColor = Colors.grey,
    this.progressColor = Colors.white,
    required this.isVibration,
  });

  final String title;
  final String imageUrl;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;
  final double progress;
  final int learnedQuestion;
  final int totalQuestion;
  final int correctQuestion;
  final int wrongQuestion;
  final Color backgroundColor;
  final Color titleColor;
  final Color backgroundProgressColor;
  final Color progressColor;
  final bool isVibration;

  @override
  Widget build(BuildContext context) {
    final String topicStatus = (correctQuestion == 0 && wrongQuestion == 0)
        ? ''
        : (correctQuestion == 0 && wrongQuestion != 0)
        ? '$wrongQuestion câu sai'
        : (correctQuestion != 0 && wrongQuestion == 0)
        ? '$correctQuestion câu đúng'
        : '$wrongQuestion câu sai | $correctQuestion câu đúng';

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () async {
          if (isVibration && (await Vibration.hasVibrator() ?? false)) {
            Vibration.vibrate(duration: 20);
          }
          onTap();
        },
        child:
        Container(
          //width: width,
          //height: height, // this
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    imageUrl,
                    height: 30,
                    width: 30,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(width: 8),
                  Text(title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // thanh tiến trình
              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: backgroundProgressColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$learnedQuestion/$totalQuestion câu hỏi',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  if (topicStatus.isNotEmpty)
                  Expanded(
                    child: Text(
                      topicStatus,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}