import 'package:ai_real_estate/app/router.dart';
import 'package:ai_real_estate/providers/settings_provider.dart';
import 'package:ai_real_estate/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiRealEstateApp extends ConsumerWidget {
  const AiRealEstateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      title: 'AI Real Estate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
