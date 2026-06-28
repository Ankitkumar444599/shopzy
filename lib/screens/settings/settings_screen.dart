import 'package:ai_real_estate/providers/settings_provider.dart';
import 'package:ai_real_estate/services/auth_service.dart';
import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context, WidgetRef ref) { final s = ref.watch(settingsProvider); return AppShell(title: 'Settings', child: ListView(padding: const EdgeInsets.all(20), children: [SwitchListTile(title: const Text('Dark mode'), value: s.darkMode, onChanged: ref.read(settingsProvider.notifier).toggleDarkMode), SwitchListTile(title: const Text('Notifications'), value: s.notifications, onChanged: ref.read(settingsProvider.notifier).toggleNotifications), const ListTile(leading: Icon(Icons.language), title: Text('Language'), subtitle: Text('English')), const ListTile(leading: Icon(Icons.person_outline), title: Text('Profile')), const ListTile(leading: Icon(Icons.info_outline), title: Text('About AI Real Estate')), const ListTile(leading: Icon(Icons.privacy_tip_outlined), title: Text('Privacy Policy')), FilledButton.tonal(onPressed: AuthService().logout, child: const Text('Logout'))])); } }
