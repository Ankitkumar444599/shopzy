import 'package:ai_real_estate/services/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class SettingsState {
  const SettingsState({
    this.darkMode = false,
    this.language = 'English',
    this.notifications = true,
  });

  final bool darkMode;
  final String language;
  final bool notifications;

  SettingsState copyWith({bool? darkMode, String? language, bool? notifications}) => SettingsState(
        darkMode: darkMode ?? this.darkMode,
        language: language ?? this.language,
        notifications: notifications ?? this.notifications,
      );
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier({Box<dynamic>? box})
      : _box = box ?? Hive.box(LocalStorageService.settingsBox),
        super(
          SettingsState(
            darkMode: (box ?? Hive.box(LocalStorageService.settingsBox)).get('darkMode', defaultValue: false) as bool,
            language: (box ?? Hive.box(LocalStorageService.settingsBox)).get('language', defaultValue: 'English') as String,
            notifications: (box ?? Hive.box(LocalStorageService.settingsBox)).get('notifications', defaultValue: true) as bool,
          ),
        );

  final Box<dynamic> _box;

  Future<void> toggleDarkMode(bool value) async {
    state = state.copyWith(darkMode: value);
    await _box.put('darkMode', value);
  }

  Future<void> toggleNotifications(bool value) async {
    state = state.copyWith(notifications: value);
    await _box.put('notifications', value);
  }

  Future<void> setLanguage(String value) async {
    state = state.copyWith(language: value);
    await _box.put('language', value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
