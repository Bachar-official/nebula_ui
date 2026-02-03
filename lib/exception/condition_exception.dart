class ConditionException implements Exception {
  final String message;

  ConditionException(this.message);

  @override
  String toString() => message;
}