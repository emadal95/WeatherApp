import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/utils/extensions.dart';
import 'settings_service.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._settingsService);
  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  late TemperatureUnit _unit;
  late List<LabeledLocationData> _locations = [];

  ThemeMode get themeMode => _themeMode;
  TemperatureUnit get unit => _unit;
  List<LabeledLocationData> get locations => _locations;

  Future<void> loadSettings() async {
    _unit = await _settingsService.unit;
    _themeMode = await _settingsService.themeMode;
    _locations = await _settingsService.locations;
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

  Future<void> addLocation(LabeledLocationData newLoc) async {
    bool exists = _locations.any(
      (loc) =>
          ((loc.latitude == newLoc.latitude) &&
              (loc.longitude == newLoc.longitude)) ||
          (loc.label.normalize() == newLoc.label.normalize()),
    );
    if (exists) return;
    _locations.insert(0, newLoc);
    notifyListeners();
    await _settingsService.addLocation(newLoc);
  }
}
