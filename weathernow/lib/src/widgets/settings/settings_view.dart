import 'package:flutter/material.dart';
import 'package:weathernow/src/widgets/settings/theme_settings.dart';
import 'package:weathernow/src/widgets/settings/unit_settings.dart';

class SettingsView extends StatefulWidget {
  static const routeName = '/settings';
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitSettings(),
          ThemeSettings(),
        ],
      ),
    );
  }
}
