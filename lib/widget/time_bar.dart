import 'package:flutter/material.dart';

class TimeBar extends StatelessWidget {
  const TimeBar({
    super.key,
    required this.totalTime,
    required this.timeLeft,
  });

  final int totalTime;
  final int timeLeft;

  @override
  Widget build(BuildContext context) {
    final min = timeLeft ~/ 60; // chia lấy phần nguyên
    final sec = timeLeft % 60; // chia lấy phần dư
    final color = min <= 3 ? Colors.red : Colors.blue;

    return SizedBox(
      height: 20,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.grey[300],
          ),
          if (timeLeft > 0)
            Align(
              alignment: Alignment.centerLeft, // Căn lề trái
              child: FractionallySizedBox(
                widthFactor: timeLeft / totalTime,
                child: Container(
                  height: 20,
                  color: color,
                  child: min > 3 // Nếu thời gian > 3 phút thì hiện text bên trong
                      ? Center(
                    child: Text(
                      (sec < 10) ? '$min:0$sec' : '$min:$sec',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  )
                      : null, // Nếu thời gian <= 3 phút thì không hiển thị text bên trong
                ),
              ),
            ),
          if (timeLeft > 0 && min <= 3) // Nếu thời gian <= 3 phút thì hiện text ra ngoài
            Positioned(
              left: (timeLeft / totalTime) * MediaQuery.of(context).size.width, // Đặt text sát bên trái thanh thời gian
              top: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Center(
                  child: Text(
                    (sec < 10) ? '$min:0$sec' : '$min:$sec',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}