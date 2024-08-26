class Settings {
  Settings({
    required this.isDarkMode,
    required this.isVibration,
  });

  final bool isDarkMode;
  final bool isVibration;

  Settings copyWith({
    bool? isDarkMode,
    bool? isVibration,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isVibration: isVibration ?? this.isVibration,
    );
  }
}