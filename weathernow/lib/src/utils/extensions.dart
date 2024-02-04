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
}
