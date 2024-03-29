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

  void onDelete() async {
    if (loc != null) settings!.removeLocation(loc!.label);
  }

  Widget forecastIcon() {
    double size = 60;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: animationBackgrounColor,
      ),
      child: prediction != null
          ? Transform.scale(
              scale: 1.2,
              child: SvgPicture.asset(
                prediction!.weatherIcon,
              ),
            )
          : null,
    );
  }

  Widget deleteButton() {
    return IconButton(
      onPressed: onDelete,
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
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
      trailing: widget.data.allowDeletion ? deleteButton() : null,
      title: Text(
        widget.data.label.startCase(),
        style: const TextStyle(inherit: true, fontWeight: FontWeight.bold),
      ),
      visualDensity: VisualDensity.comfortable,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}
