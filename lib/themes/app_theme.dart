import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => _theme(ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB), brightness: Brightness.light));
  static ThemeData get dark => _theme(ColorScheme.fromSeed(seedColor: const Color(0xFF60A5FA), brightness: Brightness.dark));
  static ThemeData _theme(ColorScheme scheme) => ThemeData(useMaterial3: true, colorScheme: scheme, cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))), inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))));
}
