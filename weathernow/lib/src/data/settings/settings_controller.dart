import 'package:flutter/material.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);
  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  late TemperatureUnit _unit;

  ThemeMode get themeMode => _themeMode;
  TemperatureUnit get unit => _unit;

  Future<void> loadSettings() async {
    _unit = await _settingsService.unit;
    _themeMode = await _settingsService.themeMode;
    notifyListeners();
  }

  Future<void> updateUnit(TemperatureUnit newUnit) async {
    _unit = newUnit;
    notifyListeners();
    await _settingsService.updateUnit(newUnit);
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
