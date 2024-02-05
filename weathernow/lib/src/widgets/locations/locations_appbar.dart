import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/models/labeled_location_data.dart';
import 'package:weathernow/src/utils/constants.dart';
import 'package:weathernow/src/widgets/dialogs/add_location_dialog.dart';
import 'package:weathernow/src/widgets/settings/settings_view.dart';

class LocationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  SettingsController settingsController;

  LocationsAppBar({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  void navToSettings(BuildContext context) {
    Navigator.restorablePushNamed(context, SettingsView.routeName);
  }

  void onAddLocation(BuildContext context) async {
    LabeledLocationData? selectedLocation =
        await showModalBottomSheet<LabeledLocationData?>(
      context: context,
      elevation: 5,
      scrollControlDisabledMaxHeightRatio: 0.8,
      builder: (_) => AddLocationDialog(),
    );

    if (selectedLocation != null) {
      settingsController.addLocation(selectedLocation);
    }
  }

  Widget iconButton({required IconData icon, Function()? onTap}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(locationsPageTitle),
      automaticallyImplyLeading: false,
      actions: [
        iconButton(icon: Icons.settings, onTap: () => navToSettings(context)),
        iconButton(
          icon: Icons.add_location_alt,
          onTap: () => onAddLocation(context),
        )
      ],
    );
  }
}
