import 'package:equatable/equatable.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/models/weather_prediction.dart';
import 'package:weathernow/src/utils/extensions.dart';

class Forecast with EquatableMixin {
  List<WeatherPrediction> predictions;

  Forecast({
    this.predictions = const [],
  });

  WeatherPrediction? getWeatherForDate(DateTime date) {
    return predictions.firstWhereOrNull(
      (p) => (p.date != null) ? date.isAtSameMomentAs(p.date!) : false,
    );
  }

  @override
  List<Object?> get props => [predictions];

  static Forecast parse(
    Map<String, dynamic> data,
    Map<String, dynamic> units,
  ) {
    List<String> days = (data['time'] as List? ?? []).cast<String>();
    List<int> weatherCodes = (data['weather_code'] as List? ?? []).cast<int>();
    List<double> maxTemperatures =
        (data['temperature_2m_max'] as List? ?? []).cast<double>();
    List<double> minTemperatures =
        (data['temperature_2m_min'] as List? ?? []).cast<double>();
    List<double> temperatures = maxTemperatures.mapIndexed<double>(
      (max, i) => ((max + minTemperatures[i]) / 2),
    );

    return Forecast(
      predictions: days
          .mapIndexed<WeatherPrediction>(
            (day, i) => WeatherPrediction(
              date: DateTimeX.fromWeatherService(day),
              weatherCode: weatherCodes[i],
              temperature: Temperature.parse(
                temperatures[i],
                units['temperature_2m_max'] as String?,
              ),
            ),
          )
          .toList(),
    );
  }
}
