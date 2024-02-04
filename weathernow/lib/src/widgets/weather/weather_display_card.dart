import 'package:flutter/material.dart';

class WeatherDisplayCard extends StatelessWidget {
  String value;
  double fontSize;
  bool chipShape;
  double minHeight;
  double minWidth;
  String? title;
  String? subtitle;

  WeatherDisplayCard(
    this.value, {
    Key? key,
    this.fontSize = 30,
    this.chipShape = false,
    this.minHeight = 110,
    this.minWidth = 150,
    this.title,
    this.subtitle,
  }) : super(key: key);

  Widget text(String txt, double size) => FittedBox(
        fit: BoxFit.contain,
        child: Text(
          txt,
          softWrap: true,
          style: TextStyle(
            inherit: true,
            fontSize: size,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(chipShape ? 100 : 10),
      ),
      elevation: 1,
      color: Theme.of(context).cardColor.withOpacity(0.5),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: minWidth,
          maxWidth: MediaQuery.of(context).size.width / 1.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              chipShape ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            if (title != null) text(title!, fontSize * 0.5),
            text(value, fontSize),
            if (subtitle != null) text(subtitle!, fontSize * 0.5),
          ],
        ),
      ),
    );
  }
}
