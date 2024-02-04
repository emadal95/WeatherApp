import 'package:equatable/equatable.dart';
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
}
