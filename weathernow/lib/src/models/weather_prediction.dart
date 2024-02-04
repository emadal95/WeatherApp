import 'package:equatable/equatable.dart';
import 'package:weather_animation/weather_animation.dart';
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
    return (WeatherCodes[weatherCode] ?? '');
  }

  String getTemperatureLabel({Temperature? toPrint}) {
    if (temperature == null && toPrint == null) return '';
    Temperature temp = toPrint ?? (temperature!);
    return '${temp.value.toStringAsFixed(0)}°${temp.unit.name[0].toUpperCase()}';
  }

  String getPrecipitationsLabel() {
    if (precipitation == null) return '';
    return '${precipitation!.toStringAsFixed(1)}mm';
  }

  @override
  List<Object?> get props => [date, weatherCode, temperature, precipitation];

  WeatherScene get weatherScene {
    switch (weatherCode) {
      case 0:
      case 1:
        return WeatherScene.scorchingSun;
      case 2:
      case 45:
      case 48:
        return WeatherScene.sunset;
      case 3:
      case 51:
      case 61:
      case 63:
      case 80:
      case 81:
        return WeatherScene.rainyOvercast;
      case 53:
      case 55:
      case 65:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherScene.stormy;
      case 56:
      case 57:
      case 66:
      case 67:
        return WeatherScene.showerSleet;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherScene.snowfall;
    }

    return WeatherScene.weatherEvery;
  }
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
