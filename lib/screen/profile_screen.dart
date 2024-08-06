import 'package:flutter/material.dart';
import 'package:gplx/widget/information.dart';

import 'chose_licence_class_screen.dart';

class ItemInList {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const ItemInList({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<ItemInList> allSettings = [
    ItemInList(
      title: 'Phản hồi rung',
      icon: Icons.vibration,
      onTap: () {},
    ),
    ItemInList(
      title: 'Xóa dữ liệu học',
      icon: Icons.delete,
      onTap: () {},
    ),
    ItemInList(
      title: 'Cài đặt khác',
      icon: Icons.other_houses,
      onTap: () {},
    ),
  ];

  final List<ItemInList> allContact = [
    ItemInList(
      title: 'Thông tin ứng dụng',
      icon: Icons.info,
      onTap: () {},
    ),
    ItemInList(
      title: 'Góp ý',
      icon: Icons.feedback,
      onTap: () {},
    ),
    ItemInList(
      title: 'Nhóm Facebook',
      icon: Icons.facebook,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void onChangeLicense() {

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ChoseLicencesClassScreen()));
    }

    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const Text('Thông tin của tôi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 16),
                // Thông tin cá nhân
                const Information(
                  name: 'Nguyễn Công Tú',
                  avatarUrl: 'assets/images/avatar.jpg',
                  description: 'Đã học được 1 tháng',
                ),
                const SizedBox(height: 24),
                const Text('Hạng GPLX',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x47E4E693),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Hạng GPLX
                  child: ListTile(
                    onTap: onChangeLicense,
                    leading: const Icon(Icons.star),
                    title: const Text(
                      'B1',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Thay đổi',
                            style: TextStyle(
                              color: Color(0xFF011D26),
                              fontSize: 16,
                            )),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Cài đặt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                // Cài đặt
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x4793CDE6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      for (final setting in allSettings)
                        ListTile(
                          onTap: setting.onTap,
                          leading: Icon(setting.icon,
                              color: setting.title.contains('Xóa')
                                  ? Colors.red
                                  : Colors.black),
                          title: Text(
                            setting.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: setting.title.contains('Xóa')
                                    ? Colors.red
                                    : Colors.black),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: setting.title.contains('Xóa')
                                  ? Colors.red
                                  : Colors.black),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Liên hệ và góp ý',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                // Liên hệ và góp ý
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x47A6DDB2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      for (final setting in allContact)
                        ListTile(
                          onTap: setting.onTap,
                          leading: Icon(setting.icon),
                          title: Text(
                            setting.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
