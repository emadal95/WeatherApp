import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/models/temperature.dart';
import 'package:weathernow/src/utils/extensions.dart';
import 'package:weathernow/src/widgets/settings/settings_tile.dart';

class UnitSettings extends StatefulWidget {
  UnitSettings({Key? key}) : super(key: key);

  @override
  State<UnitSettings> createState() => _UnitSettingsState();
}

class _UnitSettingsState extends State<UnitSettings> {
  SettingsController? controller;

  @override
  Widget build(BuildContext context) {
    controller ??= Provider.of<SettingsController>(context);

    return SettingsTile(
      label: 'Temperature Unit',
      child: DropdownButton<TemperatureUnit>(
        value: controller!.unit,
        onChanged: controller!.updateUnit,
        items: TemperatureUnit.values
            .map(
              (unit) => DropdownMenuItem(
                value: unit,
                child: Text(unit.name.startCase()),
              ),
            )
            .toList(),
      ),
    );
  }
}
