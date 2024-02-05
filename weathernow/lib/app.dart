import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/splash.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/data/settings/settings_service.dart';
import 'package:weathernow/src/data/weather_service/weather_controller.dart';
import 'package:weathernow/src/data/weather_service/weather_service.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';

import 'src/widgets/locations/location_details.dart';
import 'src/widgets/locations/locations_list.dart';
import 'src/widgets/settings/settings_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SettingsController settingsController;
  late Future<void> settingsFuture;

  @override
  void initState() {
    settingsFuture = loadSettings();
    super.initState();
  }

  Future<void> loadSettings() async {
    settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext _) => WeatherController(WeatherService()),
        ),
        ChangeNotifierProvider(
          create: (BuildContext _) => settingsController,
        ),
      ],
      child: FutureBuilder(
          future: settingsFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SplashScreen();
            }

            return MaterialApp(
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
              debugShowCheckedModeBanner: false,
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    switch (routeSettings.name) {
                      case SettingsView.routeName:
                        return SettingsView(controller: settingsController);
                      case LocationsList.routeName:
                        return ListenableBuilder(
                          listenable: settingsController,
                          builder: (_, __) => LocationsList(
                            settingsController: settingsController,
                          ),
                        );
                      case LocationDetails.routeName:
                      default:
                        return LocationDetails(
                          settingsController: settingsController,
                          location:
                              routeSettings.arguments as LabeledLocationData?,
                        );
                    }
                  },
                );
              },
            );
          }),
    );
  }
}
