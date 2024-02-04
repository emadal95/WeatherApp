import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/data/weather_service/weather_controller.dart';
import 'package:weathernow/src/models/weather_data.dart';
import 'package:weathernow/src/utils/utility.dart';
import 'package:weathernow/src/widgets/locations/locations_list.dart';
import 'package:weathernow/src/widgets/weather/weather_animation_background.dart';
import 'package:weathernow/src/widgets/weather/weather_display_card.dart';

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

  void onBack() {
    Navigator.pushReplacementNamed(context, LocationsList.routeName);
    provider!.clearData();
  }

  Widget currentTemperature() {
    return WeatherDisplayCard(
      data!.currentWeather.getTemperatureLabel(),
      fontSize: 50,
    );
  }

  Widget currentConditions() {
    return WeatherDisplayCard(
      data!.currentWeather.getWeatherCodeLabel(),
      chipShape: true,
      minHeight: 10,
      fontSize: 20,
    );
  }

  Widget currentHumidity() {
    return WeatherDisplayCard(
      data!.currentWeather.humidityPercentLabel(),
      title: 'Humidity',
    );
  }

  Widget windSpeed() {
    return WeatherDisplayCard(
      data!.currentWeather.windSpeedLabel(),
      title: 'Wind',
    );
  }

  Widget feelsLike() {
    return WeatherDisplayCard(
      data!.currentWeather.getTemperatureLabel(
        toPrint: data!.currentWeather.apparentTemperature,
      ),
      title: 'Feels like',
    );
  }

  Widget precipitations() {
    return WeatherDisplayCard(
      data!.currentWeather.getPrecipitationsLabel(),
      title: 'Precipitations',
    );
  }

  Widget row({required List<Widget> children}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget details() {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        WeatherAnimation(data?.currentWeather.weatherScene),
        if (data != null) ...[
          Positioned(
            top: 0,
            left: 24,
            child: SafeArea(child: BackButton(onPressed: onBack)),
          ),
          Positioned(
            top: mediaQuery.size.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                currentTemperature(),
                currentConditions(),
                row(children: [precipitations(), feelsLike()]),
                row(children: [currentHumidity(), windSpeed()]),
              ],
            ),
          ),
        ]
      ],
    );
  }

  Widget get verticalSpacer => const SizedBox(height: 16);

  WeatherData? get data => provider?.weatherData;

  @override
  Widget build(BuildContext context) {
    provider ??= Provider.of<WeatherController>(context);
    dataFuture ??= loadData();

    return Scaffold(
      body: FutureBuilder(
        future: dataFuture,
        builder: (_, snapshot) => details(),
      ),
    );
  }
}
