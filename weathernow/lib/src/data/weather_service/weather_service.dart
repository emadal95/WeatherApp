import 'dart:convert';
import 'package:weathernow/src/data/weather_service/weather_service_const.dart';
import 'package:weathernow/src/models/current_weather.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_data.dart';
import 'package:http/http.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/models/weather_prediction.dart';

class WeatherService {
  Future<WeatherPrediction?> getWeatherCode(
    LabeledLocationData loc,
    TemperatureUnit unit,
  ) async {
    Response resp = await get(
      Uri.https(host, endpoint, {
        'latitude': loc.latitude.toStringAsFixed(2),
        'longitude': loc.longitude.toStringAsFixed(2),
        'current': 'is_day,weather_code',
        'temperature_unit': unit.name,
      }),
    );

    if (OK_STATUS_CODES.contains(resp.statusCode)) {
      Map<String, dynamic> body = json.decode(resp.body);
      Map<String, dynamic> current = body['current'];
      Map<String, dynamic> units = body['current_units'];
      return CurrentWeather.parse(current, units);
    }

    return null;
  }

  Future<WeatherData?> getWeatherData(
    LabeledLocationData loc,
    TemperatureUnit unit,
  ) async {
    try {
      Response resp = await get(
        Uri.https(
          host,
          endpoint,
          {
            'latitude': loc.latitude.toStringAsFixed(2),
            'longitude': loc.longitude.toStringAsFixed(2),
            'current':
                'temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,wind_speed_10m',
            'daily':
                'weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum',
            'temperature_unit': unit.name,
          },
        ),
      );

      if (OK_STATUS_CODES.contains(resp.statusCode)) {
        return WeatherData.parse(json.decode(resp.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
