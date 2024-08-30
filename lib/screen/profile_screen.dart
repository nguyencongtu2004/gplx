import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx/provider/question_provider.dart';
import 'package:gplx/screen/home_screen.dart';
import 'package:gplx/widget/information.dart';

import '../provider/license_class_provider.dart';
import '../provider/settings_provider.dart';

class ItemInList {
  final String title;
  final IconData icon;
  final bool isSwitch;
  final Color color;
  final Widget? trailing;

  const ItemInList({
    required this.title,
    required this.icon,
    this.isSwitch = false,
    this.color = Colors.black,
    this.trailing,
  });
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final List<ItemInList> allSettings = [
    const ItemInList(
      title: 'Phản hồi rung',
      icon: Icons.vibration,
      isSwitch: true,
    ),
    const ItemInList(
      title: 'Chế độ tối',
      icon: Icons.nightlight_round,
      isSwitch: true,
    ),
    const ItemInList(
      title: 'Xóa dữ liệu học',
      icon: Icons.delete,
      color: Colors.red,
    ),
  ];

  final List<ItemInList> allContact = [
    const ItemInList(
      title: 'Thông tin ứng dụng',
      icon: Icons.info,
      trailing: Icon(Icons.arrow_forward_ios),
    ),
    const ItemInList(
      title: 'Góp ý',
      icon: Icons.feedback,
      trailing: Icon(Icons.arrow_forward_ios),
    ),
    const ItemInList(
      title: 'Nhóm Facebook',
      icon: Icons.facebook,
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  ];

  Widget _buildItemInList(ItemInList item,
      {bool switchValue = false,
      void Function(bool)? onSwitchChanged,
      void Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(item.icon, color: item.color),
      title: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: item.color,
        ),
      ),
      trailing: item.isSwitch
          ? Switch(
              value: switchValue,
              onChanged: onSwitchChanged,
              activeColor: const Color(0xFF638B9F),
              inactiveThumbColor: const Color(0xFF7E949E),
            )
          : item.trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  void onChangeLicense() {
    context.push('/chose-licence-class');
  }

  void onChangeVibration(bool newValue) {
    ref.read(settingsProvider.notifier).changeVibration(newValue);
  }

  void onChangeTheme(bool newValue) {
    ref.read(settingsProvider.notifier).changeTheme(newValue);
  }

  void onResetQuestions() {
    // hiển thị dialog xác nhận
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn xóa dữ liệu học?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(questionProvider.notifier).resetQuestionsState();
                // todo: cập nhật tiến trình học
                // todo: toast thông báo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã xóa dữ liệu học'),
                  ),
                );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  void onInfoApp() {
    // hiển thị bottom sheet thông tin ứng dụng
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text('Thông tin ứng dụng',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 16),
              ListTile(
                title: Text('Phiên bản 1.0.0'),
                subtitle: Text('Ứng dụng học lý thuyết lái xe A1'),
              ),
              ListTile(
                title: Text('Nhà phát triển'),
                subtitle: Text('Nguyễn Công Tú'),
              ),
              ListTile(
                title: Text('thêm...'),),
            ],
          );
        });
  }

  void onFeedback() {
    // todo: mở trình gửi email
  }

  void onFacebookGroup() {
    // todo: mở trình duyệt đến nhóm facebook
  }

  @override
  Widget build(BuildContext context) {
    // select là chỉ quan tâm đến giá trị cần theo dõi
    // không dùng watch trong initState
    final isDarkMode =
        ref.watch(settingsProvider.select((value) => value.isDarkMode));
    final isVibration =
        ref.watch(settingsProvider.select((value) => value.isVibration));

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
                title: Text(
                  'Hạng ${ref.watch(licenseClassProvider)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                  _buildItemInList(
                    allSettings[0],
                    switchValue: isVibration,
                    onSwitchChanged: onChangeVibration,
                    onTap: () {
                      onChangeVibration(!isVibration);
                    },
                  ),
                  _buildItemInList(
                    allSettings[1],
                    switchValue: isDarkMode,
                    onSwitchChanged: onChangeTheme,
                    onTap: () {
                      onChangeTheme(!isDarkMode);
                    },
                  ),
                  _buildItemInList(allSettings[2], onTap: onResetQuestions),
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
                  _buildItemInList(allContact[0], onTap: onInfoApp),
                  _buildItemInList(allContact[1], onTap: onFeedback),
                  _buildItemInList(allContact[2], onTap: onFacebookGroup),
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
