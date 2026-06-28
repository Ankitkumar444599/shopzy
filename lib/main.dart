import 'package:ai_real_estate/app/app.dart';
import 'package:ai_real_estate/services/local_storage_service.dart';
import 'package:ai_real_estate/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorageService.init();
  await NotificationService.init();
  runApp(const ProviderScope(child: AiRealEstateApp()));
}
