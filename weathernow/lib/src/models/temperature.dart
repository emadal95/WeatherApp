import 'package:equatable/equatable.dart';

class Temperature with EquatableMixin {
  late TemperatureUnit unit;

  late double value;

  Temperature({required this.unit, required this.value});

  @override
  List<Object?> get props => [unit, value];

  static Temperature parse(
    double? value,
    String? serviceUnit,
  ) {
    return Temperature(
      unit: (serviceUnit ?? '').endsWith('C')
          ? TemperatureUnit.celsius
          : TemperatureUnit.fahrenheit,
      value: value ?? -1,
    );
  }
}

enum TemperatureUnit { celsius, fahrenheit }
