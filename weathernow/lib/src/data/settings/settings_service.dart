import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weathernow/src/data/shared_preferences/preferences_const.dart';
import 'package:weathernow/src/data/shared_preferences/preferences_controller.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/utils/extensions.dart';

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

  Future<List<LabeledLocationData>> get locations async {
    List<String>? prefferedLocs =
        await PreferencesController.getPreference<List<String>>(
      PreferenceKey.locations,
    );

    if (prefferedLocs == null) return [];

    return prefferedLocs.map((locData) {
      Map<String, dynamic> decoded = json.decode(locData);
      return LabeledLocationData.fromMap(decoded);
    }).toList();
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

  Future<void> addLocation(LabeledLocationData loc) async {
    List<String> locations =
        await PreferencesController.getPreference<List<String>>(
              PreferenceKey.locations,
            ) ??
            [];
    locations.insert(0, json.encode(loc.toMap()));
    await PreferencesController.savePreference(
      PreferenceKey.locations,
      locations,
    );
  }

  Future<void> removeLocation(String id) async {
    List<String> locations =
        await PreferencesController.getPreference<List<String>>(
              PreferenceKey.locations,
            ) ??
            [];
    locations.removeWhere(
      (l) =>
          LabeledLocationData.fromMap(json.decode(l)).label.normalize() ==
          id.normalize(),
    );
    await PreferencesController.savePreference(
      PreferenceKey.locations,
      locations,
    );
  }
}
