import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weathernow/src/data/weather_service/weather_service.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_data.dart';

class WeatherController with ChangeNotifier {
  WeatherController(this._weatherService);
  final WeatherService _weatherService;
  late WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  Future<void> loadWeather(LocationData loc, TemperatureUnit unit) async {
    _weatherData = await _weatherService.getWeatherData(loc, unit);
    inspect(_weatherData);
    notifyListeners();
  }

  Future<void> updateWeatherData(WeatherData newData) async {
    if (newData == _weatherData) return;
    _weatherData = newData;
    notifyListeners();
  }
}
