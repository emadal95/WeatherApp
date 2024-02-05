import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weathernow/src/utils/constants.dart';

class WeatherAnimation extends StatelessWidget {
  WeatherScene? scene;
  WeatherAnimation(this.scene, {Key? key}) : super(key: key);

  Widget baseContainer({Widget? child}) {
    return Container(
      alignment: Alignment.center,
      color: animationBackgrounColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return baseContainer(
      child: Transform.scale(
        scale: 1.8,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 0),
          switchOutCurve: Curves.linear,
          switchInCurve: Curves.linear,
          child: baseContainer(),
          transitionBuilder: (child, animation) => AnimatedOpacity(
            duration: const Duration(milliseconds: 600),
            opacity: animation.value,
            child: scene == null
                ? baseContainer()
                : WeatherSceneWidget(
                    weatherScene: scene!,
                  ),
          ),
        ),
      ),
    );
  }
}
