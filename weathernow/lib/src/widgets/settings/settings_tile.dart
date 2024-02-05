import 'package:flutter/widgets.dart';

class SettingsTile extends StatelessWidget {
  Widget child;
  String label;
  SettingsTile({
    Key? key,
    required this.child,
    required this.label,
  }) : super(key: key);

  Widget title() => Text(
        label,
        style: const TextStyle(
          inherit: true,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          child,
        ],
      ),
    );
  }
}
