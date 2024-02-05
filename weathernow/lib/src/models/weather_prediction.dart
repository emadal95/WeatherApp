import 'package:equatable/equatable.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/utils/constants.dart';
import 'package:weathernow/src/utils/extensions.dart';

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

  String get weatherIcon {
    return WeatherAnimations[weatherScene]?['svg'] as String? ?? iconClear;
  }

  WeatherScene get weatherScene {
    return WeatherAnimations.keys.firstWhereOrNull((k) =>
            (WeatherAnimations[k]?['codes'] as List<int>? ?? [].cast<int>())
                .contains(weatherCode)) ??
        WeatherScene.weatherEvery;
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

const WeatherAnimations = {
  WeatherScene.scorchingSun: {
    'codes': [0, 1],
    'svg': iconClear,
  },
  WeatherScene.sunset: {
    'codes': [2, 45, 48],
    'svg': iconCloudy,
  },
  WeatherScene.rainyOvercast: {
    'codes': [3, 51, 61, 63, 80, 81],
    'svg': iconRainy,
  },
  WeatherScene.stormy: {
    'codes': [53, 55, 65, 82, 95, 96, 99],
    'svg': iconStorm,
  },
  WeatherScene.showerSleet: {
    'codes': [56, 57, 66, 67],
    'svg': iconSnowy,
  },
  WeatherScene.snowfall: {
    'codes': [71, 73, 75, 77, 85, 86],
    'svg': iconSnowy,
  },
};
