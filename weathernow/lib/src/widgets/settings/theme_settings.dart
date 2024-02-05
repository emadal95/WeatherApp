import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/utils/extensions.dart';
import 'package:weathernow/src/widgets/settings/settings_tile.dart';

class ThemeSettings extends StatefulWidget {
  ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  SettingsController? controller;

  @override
  Widget build(BuildContext context) {
    controller ??= Provider.of<SettingsController>(context);

    return SettingsTile(
      label: 'Color Theme',
      child: DropdownButton<ThemeMode>(
        value: controller!.themeMode,
        onChanged: controller!.updateThemeMode,
        items: ThemeMode.values
            .map(
              (mode) => DropdownMenuItem(
                value: mode,
                child: Text(mode.name.startCase()),
              ),
            )
            .toList(),
      ),
    );
  }
}
