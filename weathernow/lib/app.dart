import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/data/settings/settings_service.dart';
import 'package:weathernow/src/data/weather_service/weather_controller.dart';
import 'package:weathernow/src/data/weather_service/weather_service.dart';

import 'src/widgets/locations/location_details.dart';
import 'src/widgets/locations/locations_list.dart';
import 'src/widgets/settings/settings_view.dart';

class MyApp extends StatefulWidget {
  SettingsController settingsController;

  MyApp({
    super.key,
    required this.settingsController,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext _) => WeatherController(WeatherService()),
        ),
        ChangeNotifierProvider(
          create: (BuildContext _) => SettingsController(SettingsService()),
        ),
      ],
      child: MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
        ],
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: widget.settingsController.themeMode,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return SettingsView(controller: widget.settingsController);
                case LocationsList.routeName:
                  return LocationsList(
                    settingsController: widget.settingsController,
                  );
                case LocationDetails.routeName:
                default:
                  return LocationDetails(
                    settingsController: widget.settingsController,
                  );
              }
            },
          );
        },
      ),
    );
  }
}
