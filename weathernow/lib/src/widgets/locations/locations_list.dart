import 'package:flutter/material.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/models/location_tile_data.dart';
import 'package:weathernow/src/utils/constants.dart';
import 'package:weathernow/src/utils/extensions.dart';
import 'package:weathernow/src/widgets/locations/location_tile.dart';
import 'package:weathernow/src/widgets/locations/locations_appbar.dart';

class LocationsList extends StatefulWidget {
  static const routeName = '/list';
  SettingsController settingsController;

  LocationsList({
    super.key,
    required this.settingsController,
  });

  @override
  State<LocationsList> createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  Widget locationListItem(LocationTileData data) {
    return LocationListTile(
      data,
      key: Key('${data.index}'),
    );
  }

  List<LocationTileData> get locations {
    LocationTileData currentLocation = LocationTileData(
      index: 0,
      label: myLocationLabel,
      allowDeletion: false,
      // null location will automatically have the details page fetch current user location:
      location: null,
    );
    List<LocationTileData> userLocations = widget.settingsController.locations
        .mapIndexed(
          (loc, i) => LocationTileData(
            index: i + 1,
            label: loc.label,
            location: loc,
          ),
        )
        .toList();

    return [currentLocation, ...userLocations];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocationsAppBar(settingsController: widget.settingsController),
      body: ListView.builder(
        restorationId: 'LocationsList',
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) => locationListItem(
          locations[index],
        ),
      ),
    );
  }
}
