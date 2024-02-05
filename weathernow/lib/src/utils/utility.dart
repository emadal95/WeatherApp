import 'package:location/location.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/utils/constants.dart';

class Utils {
  static Future<LabeledLocationData?> getDeviceLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return LabeledLocationData.fromLocationData(
      await location.getLocation(),
      myLocationLabel,
    );
  }
}
