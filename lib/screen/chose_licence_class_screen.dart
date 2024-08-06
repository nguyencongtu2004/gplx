import 'package:flutter/material.dart';

class LicenseClassItem {
  final String title;
  final String description;
  final String imageUrl;

  const LicenseClassItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class ChoseLicencesClassScreen extends StatelessWidget {
  ChoseLicencesClassScreen({super.key});

  final List<LicenseClassItem> allMotorbikeLicenses = [
    const LicenseClassItem(
      title: 'A1',
      description: 'Điều khiển xe mô tô hai bánh có dung tích xi lanh từ 50 cm3 đến dưới 175 cm3, xe mô tô ba bánh dùng cho người khuyết tật.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'A2',
      description: 'Điều khiển xe mô tô hai bánh có dung tích xi lanh từ 175 cm3 trở lên và các loại xe quy định cho giấy phép lái xe hạng A1.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'A3',
      description: 'Điều khiển xe mô tô ba bánh, bao gồm cả xe lam, xích lô máy và các loại xe quy định cho giấy phép lối xe hạng A1.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'A4',
      description: 'Điều khiển các loại máy kéo nhỏ có trọng tải đến 1000 kg.',
      imageUrl: 'assets/images/place-holder.png',
    ),
  ];

  final List<LicenseClassItem> allCarLicenses = [
    const LicenseClassItem(
      title: 'B1',
      description: 'Ô tô chở người đến 9 chỗ ngồi, kể cả chỗ ngồi cho người lái xe; Ô tô tải, kể cả ô tô tải chuyên dùng có trọng tải thiết kế dưới 3500 kg; Máy kéo kéo một rơ moóc có trọng tải thiết kế dưới 3500 kg.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'B2',
      description: 'Ô tô chuyên dùng có trọng tải thiết kế dưới 3500 kg; Các loại xe quy định cho giấy phép lái xe hạng B1.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'C',
      description: 'Ô tô tải, kể cả ô tô tải chuyên dùng, ô tô chuyên dùng có trọng tải thiết kế từ 3500 kg trở lên; Máy kéo kéo một rơ moóc có trọng tải thiết kế từ 3500 kg trở lên;',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'D',
      description: 'Ô tô chở người từ 10 đến 30 chỗ ngồi, kể cả chỗ ngồi cho người lái xe; Các loại xe quy định cho giấy phép lái xe hạng B1, B2 và C.',
      imageUrl: 'assets/images/place-holder.png',
    ),
    const LicenseClassItem(
      title: 'E',
      description: 'Ô tô chở người trên 30 chỗ ngồi; Các loại xe quy định cho giấy phép lái xe hạng B1, B2, C và D.',
      imageUrl: 'assets/images/place-holder.png',
    ),
  ];

  final List<LicenseClassItem> allTruckLicenses = [
    const LicenseClassItem(
      title: 'F',
      description: 'Dành cho người đã có bằng lái xe các hạng B2, C, D và E để điều khiển các loại xe ô tô tương ứng kéo rơ moóc có trọng tải thiết kế lớn hơn 750 kg, sơ mi rơ moóc, ô tô khách nối toa.',
      imageUrl: 'assets/images/place-holder.png',
    ),
  ];

  Widget _buildLicenseClassItem(BuildContext context, LicenseClassItem item) {
    return GestureDetector(
      onTap: () {
        print('Chọn hạng thi ${item.title}');
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(item.imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B6A6A),
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn hạng thi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ô tô
              const Text('Mô tô',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              const Divider(),
              const SizedBox(height: 8),
              for (final item in allMotorbikeLicenses)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildLicenseClassItem(context, item),
                ),
              // Ô tô
              const SizedBox(height: 8),
              const Text('Ô tô',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              const Divider(),
              const SizedBox(height: 8),
              for (final item in allCarLicenses)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildLicenseClassItem(context, item),
                ),
              // Khác
              const SizedBox(height: 8),
              const Text('Khác',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              const Divider(),
              const SizedBox(height: 8),
              for (final item in allTruckLicenses)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildLicenseClassItem(context, item),
                ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
