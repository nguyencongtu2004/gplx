import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

ThemeData darkMode = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
///////////////////////////

TextTheme textTheme = const TextTheme(
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  // body
  bodySmall: TextStyle(
    fontSize: 14,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
  ),
  bodyLarge: TextStyle(
    fontSize: 18,
  ),
  // title
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  // dùng cho appbar
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
  displaySmall: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
);

ThemeData newDarkMode = MaterialTheme(textTheme).dark();
ThemeData newLightMode = MaterialTheme(textTheme).light();




class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282474385),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292273151),
      onPrimaryContainer: Color(4278197054),
      secondary: Color(4283850609),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292535033),
      onSecondaryContainer: Color(4279442475),
      tertiary: Color(4285551989),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294629629),
      onTertiaryContainer: Color(4280816430),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282664782),
      outline: Color(4285822847),
      outlineVariant: Color(4291086032),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292535033),
      onSecondaryFixed: Color(4279442475),
      secondaryFixedDim: Color(4290692828),
      onSecondaryFixedVariant: Color(4282271577),
      tertiaryFixed: Color(4294629629),
      onTertiaryFixed: Color(4280816430),
      tertiaryFixedDim: Color(4292721888),
      onTertiaryFixedVariant: Color(4283907676),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280501107),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283987368),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282008404),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285298056),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283578968),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287064972),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282401610),
      outline: Color(4284243815),
      outlineVariant: Color(4286085763),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4283987368),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282277006),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285298056),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283653231),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287064972),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285354866),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278198602),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280501107),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279837234),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282008404),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281342517),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283578968),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280362027),
      outline: Color(4282401610),
      outlineVariant: Color(4282401610),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4293258495),
      primaryFixed: Color(4280501107),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278463579),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282008404),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280560957),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283578968),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282065984),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289382399),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278857823),
      primaryContainer: Color(4280829815),
      onPrimaryContainer: Color(4292273151),
      secondary: Color(4290692828),
      onSecondary: Color(4280824129),
      secondaryContainer: Color(4282271577),
      onSecondaryContainer: Color(4292535033),
      tertiary: Color(4292721888),
      onTertiary: Color(4282329156),
      tertiaryContainer: Color(4283907676),
      onTertiaryContainer: Color(4294629629),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309080),
      onSurface: Color(4293059305),
      onSurfaceVariant: Color(4291086032),
      outline: Color(4287533209),
      outlineVariant: Color(4282664782),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4282474385),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292535033),
      onSecondaryFixed: Color(4279442475),
      secondaryFixedDim: Color(4290692828),
      onSecondaryFixedVariant: Color(4282271577),
      tertiaryFixed: Color(4294629629),
      onTertiaryFixed: Color(4280816430),
      tertiaryFixedDim: Color(4292721888),
      onTertiaryFixedVariant: Color(4283907676),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289842175),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278195764),
      primaryContainer: Color(4285829575),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290956256),
      onSecondary: Color(4279047718),
      secondaryContainer: Color(4287140261),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292985061),
      onTertiary: Color(4280487465),
      tertiaryContainer: Color(4288972713),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294703871),
      onSurfaceVariant: Color(4291349204),
      outline: Color(4288717740),
      outlineVariant: Color(4286612364),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4280895608),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278194475),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4279449189),
      secondaryFixed: Color(4292535033),
      onSecondaryFixed: Color(4278718753),
      secondaryFixedDim: Color(4290692828),
      onSecondaryFixedVariant: Color(4281218631),
      tertiaryFixed: Color(4294629629),
      onTertiaryFixed: Color(4280092707),
      tertiaryFixedDim: Color(4292721888),
      onTertiaryFixedVariant: Color(4282723914),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289842175),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290956256),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292985061),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291349204),
      outlineVariant: Color(4291349204),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4278200665),
      primaryFixed: Color(4292732927),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289842175),
      onPrimaryFixedVariant: Color(4278195764),
      secondaryFixed: Color(4292798461),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290956256),
      onSecondaryFixedVariant: Color(4279047718),
      tertiaryFixed: Color(4294761983),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292985061),
      onTertiaryFixedVariant: Color(4280487465),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  /// nenThiThu
  static const nenThiThu = ExtendedColor(
    seed: Color(4290969035),
    value: Color(4290969035),
    light: ColorFamily(
      color: Color(4281428545),
      onColor: Color(4294967295),
      colorContainer: Color(4290048446),
      onColorContainer: Color(4278198540),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4281428545),
      onColor: Color(4294967295),
      colorContainer: Color(4290048446),
      onColorContainer: Color(4278198540),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4281428545),
      onColor: Color(4294967295),
      colorContainer: Color(4290048446),
      onColorContainer: Color(4278198540),
    ),
    dark: ColorFamily(
      color: Color(4288205987),
      onColor: Color(4278204697),
      colorContainer: Color(4279718187),
      onColorContainer: Color(4290048446),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4288205987),
      onColor: Color(4278204697),
      colorContainer: Color(4279718187),
      onColorContainer: Color(4290048446),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4288205987),
      onColor: Color(4278204697),
      colorContainer: Color(4279718187),
      onColorContainer: Color(4290048446),
    ),
  );

  /// nenLapLaiNgatQuang
  static const nenLapLaiNgatQuang = ExtendedColor(
    seed: Color(4290707455),
    value: Color(4290707455),
    light: ColorFamily(
      color: Color(4278217066),
      onColor: Color(4294967295),
      colorContainer: Color(4288475633),
      onColorContainer: Color(4278198304),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4278217066),
      onColor: Color(4294967295),
      colorContainer: Color(4288475633),
      onColorContainer: Color(4278198304),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4278217066),
      onColor: Color(4294967295),
      colorContainer: Color(4288475633),
      onColorContainer: Color(4278198304),
    ),
    dark: ColorFamily(
      color: Color(4286633173),
      onColor: Color(4278204215),
      colorContainer: Color(4278210384),
      onColorContainer: Color(4288475633),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4286633173),
      onColor: Color(4278204215),
      colorContainer: Color(4278210384),
      onColorContainer: Color(4288475633),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4286633173),
      onColor: Color(4278204215),
      colorContainer: Color(4278210384),
      onColorContainer: Color(4288475633),
    ),
  );

  /// nenTruyenThong
  static const nenTruyenThong = ExtendedColor(
    seed: Color(4290707431),
    value: Color(4290707431),
    light: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    dark: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
  );

  /// nutTruyenThong
  static const nutTruyenThong = ExtendedColor(
    seed: Color(4285855672),
    value: Color(4285855672),
    light: ColorFamily(
      color: Color(4280642123),
      onColor: Color(4294967295),
      colorContainer: Color(4289458890),
      onColorContainer: Color(4278198547),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4280642123),
      onColor: Color(4294967295),
      colorContainer: Color(4289458890),
      onColorContainer: Color(4278198547),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4280642123),
      onColor: Color(4294967295),
      colorContainer: Color(4289458890),
      onColorContainer: Color(4278198547),
    ),
    dark: ColorFamily(
      color: Color(4287681967),
      onColor: Color(4278204451),
      colorContainer: Color(4278211124),
      onColorContainer: Color(4289458890),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287681967),
      onColor: Color(4278204451),
      colorContainer: Color(4278211124),
      onColorContainer: Color(4289458890),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287681967),
      onColor: Color(4278204451),
      colorContainer: Color(4278211124),
      onColorContainer: Color(4289458890),
    ),
  );

  /// nenCauHoiLuu
  static const nenCauHoiLuu = ExtendedColor(
    seed: Color(4292935674),
    value: Color(4292935674),
    light: ColorFamily(
      color: Color(4278217315),
      onColor: Color(4294967295),
      colorContainer: Color(4288541416),
      onColorContainer: Color(4278198301),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4278217315),
      onColor: Color(4294967295),
      colorContainer: Color(4288541416),
      onColorContainer: Color(4278198301),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4278217315),
      onColor: Color(4294967295),
      colorContainer: Color(4288541416),
      onColorContainer: Color(4278198301),
    ),
    dark: ColorFamily(
      color: Color(4286698956),
      onColor: Color(4278204211),
      colorContainer: Color(4278210634),
      onColorContainer: Color(4288541416),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4286698956),
      onColor: Color(4278204211),
      colorContainer: Color(4278210634),
      onColorContainer: Color(4288541416),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4286698956),
      onColor: Color(4278204211),
      colorContainer: Color(4278210634),
      onColorContainer: Color(4288541416),
    ),
  );

  /// nenCauSai
  static const nenCauSai = ExtendedColor(
    seed: Color(4294961354),
    value: Color(4294961354),
    light: ColorFamily(
      color: Color(4286404366),
      onColor: Color(4294967295),
      colorContainer: Color(4294958766),
      onColorContainer: Color(4280817664),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4286404366),
      onColor: Color(4294967295),
      colorContainer: Color(4294958766),
      onColorContainer: Color(4280817664),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4286404366),
      onColor: Color(4294967295),
      colorContainer: Color(4294958766),
      onColorContainer: Color(4280817664),
    ),
    dark: ColorFamily(
      color: Color(4294033005),
      onColor: Color(4282592256),
      colorContainer: Color(4284498176),
      onColorContainer: Color(4294958766),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294033005),
      onColor: Color(4282592256),
      colorContainer: Color(4284498176),
      onColorContainer: Color(4294958766),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294033005),
      onColor: Color(4282592256),
      colorContainer: Color(4284498176),
      onColorContainer: Color(4294958766),
    ),
  );

  /// nenCauKho
  static const nenCauKho = ExtendedColor(
    seed: Color(4294954959),
    value: Color(4294954959),
    light: ColorFamily(
      color: Color(4287580749),
      onColor: Color(4294967295),
      colorContainer: Color(4294957785),
      onColorContainer: Color(4282058766),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4287580749),
      onColor: Color(4294967295),
      colorContainer: Color(4294957785),
      onColorContainer: Color(4282058766),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4287580749),
      onColor: Color(4294967295),
      colorContainer: Color(4294957785),
      onColorContainer: Color(4282058766),
    ),
    dark: ColorFamily(
      color: Color(4294947764),
      onColor: Color(4283833633),
      colorContainer: Color(4285739830),
      onColorContainer: Color(4294957785),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294947764),
      onColor: Color(4283833633),
      colorContainer: Color(4285739830),
      onColorContainer: Color(4294957785),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294947764),
      onColor: Color(4283833633),
      colorContainer: Color(4285739830),
      onColorContainer: Color(4294957785),
    ),
  );

  /// nenGplx
  static const nenGplx = ExtendedColor(
    seed: Color(4294178017),
    value: Color(4294178017),
    light: ColorFamily(
      color: Color(4283851810),
      onColor: Color(4294967295),
      colorContainer: Color(4292471705),
      onColorContainer: Color(4279705088),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4283851810),
      onColor: Color(4294967295),
      colorContainer: Color(4292471705),
      onColorContainer: Color(4279705088),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4283851810),
      onColor: Color(4294967295),
      colorContainer: Color(4292471705),
      onColorContainer: Color(4279705088),
    ),
    dark: ColorFamily(
      color: Color(4290629248),
      onColor: Color(4280956160),
      colorContainer: Color(4282272779),
      onColorContainer: Color(4292471705),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4290629248),
      onColor: Color(4280956160),
      colorContainer: Color(4282272779),
      onColorContainer: Color(4292471705),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4290629248),
      onColor: Color(4280956160),
      colorContainer: Color(4282272779),
      onColorContainer: Color(4292471705),
    ),
  );

  /// nenCaiDat
  static const nenCaiDat = ExtendedColor(
    seed: Color(4292734456),
    value: Color(4292734456),
    light: ColorFamily(
      color: Color(4279854468),
      onColor: Color(4294967295),
      colorContainer: Color(4290963711),
      onColorContainer: Color(4278197803),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4279854468),
      onColor: Color(4294967295),
      colorContainer: Color(4290963711),
      onColorContainer: Color(4278197803),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4279854468),
      onColor: Color(4294967295),
      colorContainer: Color(4290963711),
      onColorContainer: Color(4278197803),
    ),
    dark: ColorFamily(
      color: Color(4287549426),
      onColor: Color(4278203720),
      colorContainer: Color(4278209895),
      onColorContainer: Color(4290963711),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287549426),
      onColor: Color(4278203720),
      colorContainer: Color(4278209895),
      onColorContainer: Color(4290963711),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287549426),
      onColor: Color(4278203720),
      colorContainer: Color(4278209895),
      onColorContainer: Color(4290963711),
    ),
  );

  /// nenLienHe
  static const nenLienHe = ExtendedColor(
    seed: Color(4293063402),
    value: Color(4293063402),
    light: ColorFamily(
      color: Color(4279397206),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198296),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4279397206),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198296),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4279397206),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198296),
    ),
    dark: ColorFamily(
      color: Color(4287092412),
      onColor: Color(4278204459),
      colorContainer: Color(4278210880),
      onColorContainer: Color(4288934615),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287092412),
      onColor: Color(4278204459),
      colorContainer: Color(4278210880),
      onColorContainer: Color(4288934615),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287092412),
      onColor: Color(4278204459),
      colorContainer: Color(4278210880),
      onColorContainer: Color(4288934615),
    ),
  );

  /// nenBienBao
  static const nenBienBao = ExtendedColor(
    seed: Color(4290707431),
    value: Color(4290707431),
    light: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4279462741),
      onColor: Color(4294967295),
      colorContainer: Color(4288934615),
      onColorContainer: Color(4278198552),
    ),
    dark: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287157947),
      onColor: Color(4278204459),
      colorContainer: Color(4278210879),
      onColorContainer: Color(4288934615),
    ),
  );

  /// nenMeo
  static const nenMeo = ExtendedColor(
    seed: Color(4292211665),
    value: Color(4292211665),
    light: ColorFamily(
      color: Color(4281887036),
      onColor: Color(4294967295),
      colorContainer: Color(4290375864),
      onColorContainer: Color(4278198535),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4281887036),
      onColor: Color(4294967295),
      colorContainer: Color(4290375864),
      onColorContainer: Color(4278198535),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4281887036),
      onColor: Color(4294967295),
      colorContainer: Color(4290375864),
      onColorContainer: Color(4278198535),
    ),
    dark: ColorFamily(
      color: Color(4288599197),
      onColor: Color(4278401298),
      colorContainer: Color(4280242215),
      onColorContainer: Color(4290375864),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4288599197),
      onColor: Color(4278401298),
      colorContainer: Color(4280242215),
      onColorContainer: Color(4290375864),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4288599197),
      onColor: Color(4278401298),
      colorContainer: Color(4280242215),
      onColorContainer: Color(4290375864),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    nenThiThu,
    nenLapLaiNgatQuang,
    nenTruyenThong,
    nutTruyenThong,
    nenCauHoiLuu,
    nenCauSai,
    nenCauKho,
    nenGplx,
    nenCaiDat,
    nenLienHe,
    nenBienBao,
    nenMeo,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
