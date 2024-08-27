import '../model/settings.dart';
import 'database_service.dart';

class SettingsTable {
  static Future<Settings> getSettings() async {
    final db = await DatabaseService().database;
    final data = await db!.query('settings');
    if (data.isEmpty) {
      await db.insert('settings', {'isDarkMode': 0, 'isVibration': 1, 'licenseClass': 'B2'});
      return Settings(isDarkMode: false, isVibration: true);
    }
    return Settings(
      isDarkMode: data[0]['isDarkMode'] == 1,
      isVibration: data[0]['isVibration'] == 1,
    );
  }

  static Future<String> getLicenseClass() async {
    final db = await DatabaseService().database;
    final data = await db!.query('settings');
    if (data.isEmpty) {
      await db.insert('settings', {'isDarkMode': 0, 'isVibration': 1, 'licenseClass': 'B2'});
      return 'B2';
    }
    return data[0]['licenseClass'] as String;
  }

  static Future<void> updateTheme(bool isDarkMode) async {
    final db = await DatabaseService().database;
    await db!.update('settings', {'isDarkMode': isDarkMode ? 1 : 0});
  }

  static Future<void> updateVibration(bool isVibration) async {
    final db = await DatabaseService().database;
    await db!.update('settings', {'isVibration': isVibration ? 1 : 0});
  }

  static Future<void> updateLicenseClass(String licenseClass) async {
    final db = await DatabaseService().database;
    await db!.update('settings', {'licenseClass': licenseClass});
  }

  // todo: lưu 'chỉ hiển thị biển báo trong câu hỏi' vào settings
}