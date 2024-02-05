extension ListX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) predicate) {
    try {
      return firstWhere(predicate);
    } catch (e) {
      return null;
    }
  }

  T? get firstOrNull {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  List<V> mapIndexed<V>(V Function(T element, int i) predicate) {
    List<V> result = [];
    for (int i = 0; i < length; i++) {
      result.add(predicate(elementAt(i), i));
    }
    return result;
  }
}

extension DateTimeX on DateTime {
  static DateTime? fromWeatherService(String serviceStr) {
    DateTime? parsed = DateTime.tryParse(serviceStr);
    if (parsed == null) return parsed;
    return DateTime(
      parsed.year,
      parsed.month,
      parsed.day,
    );
  }
}

extension StringX on String {
  String normalize() {
    return trim().toLowerCase();
  }

  String startCase() {
    List<String> words = split(' ');

    return words
        .map((w) => w.length < 2
            ? w.toUpperCase()
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }
}
