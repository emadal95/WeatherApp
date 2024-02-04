import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_prediction.dart';
import 'package:weathernow/src/utils/extensions.dart';

class CurrentWeather extends WeatherPrediction {
  final Temperature? apparentTemperature;
  final double? windSpeed;
  final double? humidityPercent;

  CurrentWeather({
    this.apparentTemperature,
    this.windSpeed,
    this.humidityPercent,
    double? precipitation,
    Temperature? temperature,
    int? weatherCode,
    DateTime? date,
  }) : super(
          date: date,
          temperature: temperature,
          weatherCode: weatherCode,
          precipitation: precipitation,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        apparentTemperature,
        windSpeed,
        humidityPercent,
      ];

  static CurrentWeather parse(
    Map<String, dynamic> data,
    Map<String, dynamic> units,
  ) {
    return CurrentWeather(
      date: DateTimeX.fromWeatherService(data['time']),
      apparentTemperature: Temperature.parse(
        data['apparent_temperature'] as double?,
        units['apparent_temperature'] as String?,
      ),
      temperature: Temperature.parse(
        data['temperature_2m'] as double?,
        units['temperature_2m'] as String?,
      ),
      humidityPercent: (data['relative_humidity_2m'] as int?)?.toDouble(),
      precipitation: data['precipitation'] as double?,
      weatherCode: data['weather_code'] as int?,
      windSpeed: data['wind_speed_10m'] as double?,
    );
  }
}
