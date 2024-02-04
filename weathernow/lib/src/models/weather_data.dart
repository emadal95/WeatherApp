import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:weathernow/src/models/current_weather.dart';
import 'package:weathernow/src/models/forecast.dart';

class WeatherData with EquatableMixin {
  final LocationData location;
  final CurrentWeather currentWeather;
  final Forecast forecast;

  WeatherData({
    required this.location,
    required this.currentWeather,
    required this.forecast,
  });

  @override
  List<Object?> get props => [currentWeather, forecast];

  static WeatherData? parse(Map<String, dynamic> data) {
    return WeatherData(
      location: LocationData.fromMap(data),
      currentWeather: CurrentWeather.parse(
        data['current'] as Map<String, dynamic>,
        data['current_units'] as Map<String, dynamic>,
      ),
      forecast: Forecast.parse(
        data['daily'] as Map<String, dynamic>,
        data['daily_units'] as Map<String, dynamic>,
      ),
    );
  }
}
