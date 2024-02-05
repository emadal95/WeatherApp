import 'package:weathernow/src/models/labeled_location_data.dart';

class LocationTileData {
  int index;
  String label;
  LabeledLocationData? location;

  LocationTileData({
    required this.index,
    required this.label,
    required this.location,
  });
}