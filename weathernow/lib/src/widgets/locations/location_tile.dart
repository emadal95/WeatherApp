import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/data/weather_service/weather_controller.dart';
import 'package:weathernow/src/models/location_tile_data.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/models/weather_prediction.dart';
import 'package:weathernow/src/utils/constants.dart';
import 'package:weathernow/src/utils/extensions.dart';
import 'package:weathernow/src/utils/utility.dart';
import 'package:weathernow/src/widgets/locations/location_details.dart';

class LocationListTile extends StatefulWidget {
  LocationTileData data;
  LocationListTile(this.data, {Key? key}) : super(key: key);

  @override
  State<LocationListTile> createState() => _LocationListTileState();
}

class _LocationListTileState extends State<LocationListTile> {
  WeatherController? provider;
  SettingsController? settings;
  Future<WeatherPrediction?>? weatherFuture;
  LabeledLocationData? loc;

  Future<WeatherPrediction?> loadWeather() async {
    loc = widget.data.location ?? await Utils.getDeviceLocation();

    if (loc != null) {
      return await provider!.loadWeatherCode(loc!, settings!.unit);
    }
    return null;
  }

  void openLocationWeather() {
    Navigator.of(context).pushReplacementNamed(
      LocationDetails.routeName,
      arguments: loc,
    );
  }

  Widget forecastIcon() {
    double size = MediaQuery.of(context).size.width * 0.1;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: animationBackgrounColor,
      ),
      child: prediction != null
          ? SvgPicture.asset(
              prediction!.weatherIcon,
            )
          : null,
    );
  }

  WeatherPrediction? get prediction => provider!.getLocationPrediction(loc);

  @override
  Widget build(BuildContext context) {
    provider ??= Provider.of<WeatherController>(context);
    settings ??= Provider.of<SettingsController>(context);
    weatherFuture ??= loadWeather();

    return ListTile(
      onTap: openLocationWeather,
      leading: forecastIcon(),
      title: Text(
        widget.data.label.startCase(),
        style: const TextStyle(inherit: true, fontWeight: FontWeight.bold),
      ),
      visualDensity: VisualDensity.comfortable,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}
