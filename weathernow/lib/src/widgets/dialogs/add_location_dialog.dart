import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/utils/extensions.dart';

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({Key? key}) : super(key: key);

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  Size? deviceSize;

  void onLocationPicked(LocationResult result) {
    Navigator.of(context).pop(
      LabeledLocationData.fromMap({
        'longitude': result.longitude,
        'latitude': result.latitude,
        'label': result.address.split(',').last.normalize(),
      }),
    );
  }

  Widget mapView() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      child: MapLocationPicker(
        searchBarDecoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          hintText: 'Search Location',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
        buttonText: 'Add Location',
        zoomButtonEnabled: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        mapType: MapType.normal,
        onPicked: onLocationPicked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceSize ??= MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: mapView(),
    );
  }
}
