import 'package:flutter/material.dart';

import '../widget/custom-card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            CustomCard(
              width: MediaQuery.of(context).size.width,
              height: 180,
              title: 'Thi thử',
              description: 'Sau bao ngày khổ luyện, đến lúc thử sức rồi...',
              imageUrl: 'assets/images/place-holder.png',
              titleColor: Color(0xFF012504),
              descriptionColor: Colors.black,
              backgroundColor: Color(0xFFC2FDCB),
              onTap: () {
                print('Thi thử');
              },
            ),
            CustomCard(
              width: MediaQuery.of(context).size.width,
              height: 180,
              title: 'Lặp lại cách quãng',
              description:
                  'Dựa trên việc lặp lại thông tin đã học theo khoảng cách ngày càng tăng',
              imageUrl: 'assets/images/place-holder.png',
              titleColor: Color(0xFF010925),
              descriptionColor: Colors.black,
              backgroundColor: Color(0xFFBEFFFF),
              onTap: () {
                print('Lặp lại cách quãng');
              },
            ),
            Row(
              children: [
                CustomCard(
                  width: MediaQuery.of(context).size.width / 2 - 32,
                  height: MediaQuery.of(context).size.width / 2 - 32,
                  title: 'Học từ vựng',
                  description: 'Học từ vựng qua hình ảnh',
                  imageUrl: 'assets/images/place-holder.png',
                  titleColor: Color(0xFF250101),
                  descriptionColor: Colors.black,
                  backgroundColor: Color(0xFFFFD3D3),
                  onTap: () {
                    print('Học từ vựng');
                  },
                ),
                CustomCard(
                  width: MediaQuery.of(context).size.width / 2 - 32,
                  height: MediaQuery.of(context).size.width / 2 - 32,
                  title: 'Học lý thuyết',
                  description: 'Học lý thuyết qua hình ảnh',
                  imageUrl: 'assets/images/place-holder.png',
                  titleColor: Color(0xFF250101),
                  descriptionColor: Colors.black,
                  backgroundColor: Color(0xFFFFD3D3),
                  onTap: () {
                    print('Học lý thuyết');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
