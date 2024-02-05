import 'package:flutter/material.dart';
import 'package:weathernow/src/data/weather_service/weather_service.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_data.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/models/weather_locations_data.dart';
import 'package:weathernow/src/models/weather_prediction.dart';

class WeatherController extends ChangeNotifier {
  WeatherController(this._weatherService);
  final WeatherService _weatherService;
  WeatherData? _weatherData;
  final WeatherLocationsData _locationsWeatherData = WeatherLocationsData();

  WeatherData? get weatherData => _weatherData;

  WeatherPrediction? getLocationPrediction(LabeledLocationData? loc) {
    if (loc == null) return null;
    return _locationsWeatherData.getLocationPrediction(loc.label);
  }

  Future<WeatherPrediction?> loadWeatherCode(
    LabeledLocationData loc,
    TemperatureUnit unit,
  ) async {
    WeatherPrediction? prediction = await _weatherService.getWeatherCode(
      loc,
      unit,
    );

    if (prediction != null) {
      _locationsWeatherData.addPrediction(loc.label, prediction);
      notifyListeners();
    }

    return prediction;
  }

  Future<void> loadWeather(
    LabeledLocationData loc,
    TemperatureUnit unit,
  ) async {
    _weatherData = await _weatherService.getWeatherData(loc, unit);
    notifyListeners();
  }

  Future<void> updateWeatherData(WeatherData newData) async {
    if (newData == _weatherData) return;
    _weatherData = newData;
    notifyListeners();
  }

  void clearData({bool notify = true}) {
    _weatherData = null;
    if (notify) notifyListeners();
  }
}
