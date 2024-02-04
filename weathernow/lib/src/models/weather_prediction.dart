import 'package:equatable/equatable.dart';
import 'package:weathernow/src/models/temperature.dart';

class WeatherPrediction with EquatableMixin {
  final DateTime? date;
  final int? weatherCode;

  final Temperature? temperature;
  final double? precipitation;

  WeatherPrediction({
    this.weatherCode,
    this.temperature,
    this.precipitation,
    this.date,
  });

  String getWeatherCodeLabel() {
    if (weatherCode == null) return '';
    return WeatherCodes[weatherCode] ?? '';
  }

  String getTemperatureLabel() {
    if (temperature == null) return '';
    return '${temperature!.value.toStringAsFixed(0)} °${temperature!.unit.name}';
  }

  @override
  List<Object?> get props => [date, weatherCode, temperature, precipitation];
}

const WeatherCodes = {
  0: 'Clear sky',
  1: 'Mainly clear sky',
  2: 'Partly cloudy',
  3: 'Overcast',
  45: 'Foggy',
  48: 'Depositing rime fog',
  51: 'Light drizzle',
  53: 'Moderate drizzle',
  55: 'Dense drizzle',
  56: 'Light freezing drizzle',
  57: 'Dense freezing drizzle',
  61: 'Light rain',
  63: 'Moderate rain',
  65: 'Heavy rain',
  66: 'Light freezing rain',
  67: 'Heavy freezing rain',
  71: 'Light snow',
  73: 'Moderate snow',
  75: 'Heavy snow',
  77: 'Hail',
  80: 'Light rain shower',
  81: 'Moderate rain shower',
  82: 'Violent rain shower',
  85: 'Light snow shower',
  86: 'Heavy snow shower',
  95: 'Thunderstorm',
  96: 'Thunderstorm with light hail',
  99: 'Thunderstorm with heavy hail',
};
