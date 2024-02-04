import 'package:flutter/material.dart';
import 'package:weathernow/src/data/shared_preferences/preferences_const.dart';
import 'package:weathernow/src/data/shared_preferences/preferences_controller.dart';
import 'package:weathernow/src/models/temperature.dart';

class SettingsService {
  Future<TemperatureUnit> get unit async {
    String? preferredUnit = await PreferencesController.getPreference<String>(
      PreferenceKey.unit,
    );

    if (preferredUnit != null) {
      return TemperatureUnit.values.firstWhere(
        (v) => v.name == preferredUnit,
        orElse: () => TemperatureUnit.fahrenheit,
      );
    }

    return TemperatureUnit.fahrenheit;
  }

  Future<ThemeMode> get themeMode async {
    String? preferredTheme = await PreferencesController.getPreference<String>(
      PreferenceKey.theme,
    );

    if (preferredTheme != null) {
      return ThemeMode.values.firstWhere(
        (mode) => mode.name == preferredTheme,
        orElse: () => ThemeMode.dark,
      );
    }

    await PreferencesController.savePreference(
      PreferenceKey.theme,
      ThemeMode.dark.name,
    );

    return ThemeMode.dark;
  }

  Future<void> updateUnit(TemperatureUnit newUnit) async {
    await PreferencesController.savePreference(
      PreferenceKey.unit,
      newUnit.name,
    );
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    await PreferencesController.savePreference(
      PreferenceKey.theme,
      theme.name,
    );
  }
}
