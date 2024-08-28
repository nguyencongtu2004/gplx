import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/license_class_item.dart';
import '../provider/license_class_provider.dart';

class ChoseLicencesClassScreen extends ConsumerWidget {
  const ChoseLicencesClassScreen({super.key});

  void onChoseLicenseClass(
      BuildContext context, WidgetRef ref, LicenseClassItem item) {
    print('Chọn hạng thi ${item.title}');
    ref.read(licenseClassProvider.notifier).changeLicenseClass(item.title);

    // toast thông báo
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã chọn hạng ${item.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void showLicenseClassDetail(
      BuildContext context, WidgetRef ref, LicenseClassItem item) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 128),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(item.imageUrl),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hạng ${item.title}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),
                      OutlinedButton(
                          onPressed: () {
                            onChoseLicenseClass(context, ref, item);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Chọn'))
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildLicenseClassItem(BuildContext context, WidgetRef ref,
      LicenseClassItem item, bool isSelected) {
    return InkWell(
      onTap: () => onChoseLicenseClass(context, ref, item),
      onLongPress: () => showLicenseClassDetail(context, ref, item),
      child: Container(
        color: isSelected ? Colors.grey[200] : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWithDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String selectedLicenseClass = ref.watch(licenseClassProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Column(
            children: [
              Text(
                'Chọn hạng thi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Ấn giữ để xem chi tiết',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        // thêm cho cân
        actions: [
          IconButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.list,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ô tô
            _buildTitleWithDivider('Mô tô'),
            for (final item in allMotorbikeLicenses)
              _buildLicenseClassItem(
                  context, ref, item, item.title == selectedLicenseClass),
            // Ô tô
            _buildTitleWithDivider('Ô tô'),
            for (final item in allCarLicenses)
              _buildLicenseClassItem(
                  context, ref, item, item.title == selectedLicenseClass),
            // Khác
            _buildTitleWithDivider('Khác'),
            for (final item in allTruckLicenses)
              _buildLicenseClassItem(
                  context, ref, item, item.title == selectedLicenseClass),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
