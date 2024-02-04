import 'package:flutter/material.dart';

import 'app.dart';
import 'src/data/settings/settings_controller.dart';
import 'src/data/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MyApp(settingsController: settingsController),
  );
}
