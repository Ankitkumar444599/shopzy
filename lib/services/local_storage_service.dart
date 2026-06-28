import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const predictionsBox = 'predictions';
  static const settingsBox = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(predictionsBox);
    await Hive.openBox(settingsBox);
  }
}
