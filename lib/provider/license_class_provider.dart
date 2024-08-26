import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gplx/database/settings_table.dart';

import '../model/license_class_item.dart';

class LicenseClassProvider extends StateNotifier<String> {
  LicenseClassProvider() : super('B2');

  Future<void> loadLicenseClass() async {
    final licenseClass = await SettingsTable.getLicenseClass();
    state = licenseClass;
  }

  Future<void> changeLicenseClass(String licenseClass) async {
    state = licenseClass;
    await SettingsTable.updateLicenseClass(licenseClass);
  }
}

final licenseClassProvider = StateNotifierProvider<LicenseClassProvider, String>(
  (ref) => LicenseClassProvider(),
);

// Một số dữ liệu mẫu
const List<LicenseClassItem> allMotorbikeLicenses = [
  LicenseClassItem(
    title: 'A1',
    description:
        'Điều khiển xe mô tô hai bánh có dung tích xi lanh từ 50 cm3 đến dưới 175 cm3, xe mô tô ba bánh dùng cho người khuyết tật.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'A2',
    description:
        'Điều khiển xe mô tô hai bánh có dung tích xi lanh từ 175 cm3 trở lên và các loại xe quy định cho giấy phép lái xe hạng A1.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'A3',
    description:
        'Điều khiển xe mô tô ba bánh, bao gồm cả xe lam, xích lô máy và các loại xe quy định cho giấy phép lối xe hạng A1.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'A4',
    description: 'Điều khiển các loại máy kéo nhỏ có trọng tải đến 1000 kg.',
    imageUrl: 'assets/images/place-holder.png',
  ),
];

const List<LicenseClassItem> allCarLicenses = [
  LicenseClassItem(
    title: 'B1',
    description:
        'Ô tô chở người đến 9 chỗ ngồi, kể cả chỗ ngồi cho người lái xe; Ô tô tải, kể cả ô tô tải chuyên dùng có trọng tải thiết kế dưới 3500 kg; Máy kéo kéo một rơ moóc có trọng tải thiết kế dưới 3500 kg.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'B2',
    description:
        'Ô tô chuyên dùng có trọng tải thiết kế dưới 3500 kg; Các loại xe quy định cho giấy phép lái xe hạng B1.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'C',
    description:
        'Ô tô tải, kể cả ô tô tải chuyên dùng, ô tô chuyên dùng có trọng tải thiết kế từ 3500 kg trở lên; Máy kéo kéo một rơ moóc có trọng tải thiết kế từ 3500 kg trở lên;',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'D',
    description:
        'Ô tô chở người từ 10 đến 30 chỗ ngồi, kể cả chỗ ngồi cho người lái xe; Các loại xe quy định cho giấy phép lái xe hạng B1, B2 và C.',
    imageUrl: 'assets/images/place-holder.png',
  ),
  LicenseClassItem(
    title: 'E',
    description:
        'Ô tô chở người trên 30 chỗ ngồi; Các loại xe quy định cho giấy phép lái xe hạng B1, B2, C và D.',
    imageUrl: 'assets/images/place-holder.png',
  ),
];

const List<LicenseClassItem> allTruckLicenses = [
  LicenseClassItem(
    title: 'F',
    description:
        'Dành cho người đã có bằng lái xe các hạng B2, C, D và E để điều khiển các loại xe ô tô tương ứng kéo rơ moóc có trọng tải thiết kế lớn hơn 750 kg, sơ mi rơ moóc, ô tô khách nối toa.',
    imageUrl: 'assets/images/place-holder.png',
  ),
];
