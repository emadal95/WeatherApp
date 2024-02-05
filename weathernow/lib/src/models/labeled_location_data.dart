import 'package:location/location.dart';
import 'package:weathernow/src/utils/extensions.dart';

class LabeledLocationData {
  double latitude;
  double longitude;
  String label;

  LabeledLocationData({
    required this.label,
    required this.latitude,
    required this.longitude,
  }) {
    if (label.normalize().isEmpty) {
      label = '${latitude.toStringAsFixed(2)},${longitude.toStringAsFixed(2)}';
    }
  }

  Map<String, dynamic> toMap() {
    return Map.from({
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  static LabeledLocationData fromMap(Map map) {
    return LabeledLocationData(
      label: map['label'] as String? ?? '',
      latitude: map['latitude'] as double? ?? 0.0,
      longitude: map['longitude'] as double? ?? 0.0,
    );
  }

  static LabeledLocationData fromLocationData(
    LocationData locData,
    String label,
  ) {
    return LabeledLocationData(
      label: label,
      latitude: locData.latitude ?? 0.0,
      longitude: locData.longitude ?? 0.0,
    );
  }
}
