import 'package:equatable/equatable.dart';

class Temperature with EquatableMixin {
  late TemperatureUnit unit;

  late double value;

  Temperature({required this.unit, required this.value});

  @override
  List<Object?> get props => [unit, value];
}

enum TemperatureUnit { celsius, fahrenheit }
