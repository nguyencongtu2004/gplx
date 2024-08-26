import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/settings_table.dart';
import '../model/settings.dart';

class SettingsProvider extends StateNotifier<Settings> {
  SettingsProvider() : super(Settings(isDarkMode: false, isVibration: true));

  Future<void> loadSettings() async {
    final settings = await SettingsTable.getSettings();
    state = settings;
  }

  Future<void> changeTheme(bool isDarkMode) async {
    state = state.copyWith(isDarkMode: isDarkMode);
    await SettingsTable.updateTheme(isDarkMode);
  }

  Future<void> changeVibration(bool isVibration) async {
    state = state.copyWith(isVibration: isVibration);
    await SettingsTable.updateVibration(isVibration);
  }

}

final settingsProvider = StateNotifierProvider<SettingsProvider, Settings>((ref) {
  return SettingsProvider();
});