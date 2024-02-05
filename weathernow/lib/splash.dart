import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weathernow/src/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: SvgPicture.asset(
          appIconSvg,
          width: mediaQuery.size.width * 0.5,
          height: mediaQuery.size.width * 0.5,
        ),
      ),
    );
  }
}
