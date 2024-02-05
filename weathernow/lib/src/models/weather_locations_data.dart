import 'package:weathernow/src/models/weather_prediction.dart';
import 'package:weathernow/src/utils/extensions.dart';

class WeatherLocationsData {
  late Map<String, WeatherPrediction> data;

  WeatherLocationsData() {
    data = Map.from({});
  }

  void addPrediction(String id, WeatherPrediction prediction) {
    data[id.normalize()] = prediction;
  }

  void removePrediction(String id) {
    data.remove(id.normalize());
  }

  WeatherPrediction? getLocationPrediction(String locId) {
    return data[locId.normalize()];
  }
}
