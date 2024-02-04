import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_prediction.dart';

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
}
