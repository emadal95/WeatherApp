import 'dart:convert';

import 'package:location/location.dart';
import 'package:weathernow/src/data/weather_service/weather_service_const.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_data.dart';
import 'package:http/http.dart';

class WeatherService {
  Future<WeatherData?> getWeatherData(
    LocationData loc,
    TemperatureUnit unit,
  ) async {
    try {
      Response resp = await get(
        Uri.https(
          'api.open-meteo.com',
          '/v1/forecast',
          {
            'latitude': loc.latitude?.toStringAsFixed(2),
            'longitude': loc.longitude?.toStringAsFixed(2),
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
