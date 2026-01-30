import 'package:nebula_ui/entity/condition.dart';
import 'package:nebula_ui/exception/condition_exception.dart';

mixin CEHandler {
  void checkCondition(bool condition, String message) {
    if (condition) {
      throw ConditionException(message);
    }
  }

  void checkConditions(List<Condition> conditions) {
    for (var c in conditions) {
      if (c.throwIf) {
        throw ConditionException(c.message);
      }
    }
  }
}