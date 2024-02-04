import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/data/weather_service/weather_controller.dart';
import 'package:weathernow/src/utils/utility.dart';
import 'package:weathernow/src/widgets/locations/locations_list.dart';

class LocationDetails extends StatefulWidget {
  static const routeName = '/';
  LocationData? location;
  SettingsController settingsController;

  LocationDetails({
    super.key,
    this.location,
    required this.settingsController,
  });

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  WeatherController? provider;
  Future? dataFuture;

  Future loadData() async {
    LocationData? loc = widget.location ?? await Utils.getDeviceLocation();

    if (loc != null) {
      await provider!.loadWeather(
        loc,
        widget.settingsController.unit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    provider ??= Provider.of<WeatherController>(context);
    dataFuture ??= loadData();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pushReplacementNamed(context, LocationsList.routeName);
        }),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
