import 'package:flutter/material.dart';
import 'package:weathernow/src/data/settings/settings_controller.dart';
import 'package:weathernow/src/widgets/locations/location_details.dart';
import '../settings/settings_view.dart';

class LocationsList extends StatelessWidget {
  SettingsController settingsController;

  LocationsList({
    super.key,
    required this.settingsController,
    this.items = const [1, 2, 3],
  });

  static const routeName = '/list';
  final List<int> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'LocationsList',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListTile(
              title: Text('SampleItem $item'),
              leading: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  LocationDetails.routeName,
                );
              });
        },
      ),
    );
  }
}
