import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/min_value.dart';

void main() {
  group('MinValue', () {
    test('enforces lower bound inclusively by default', () {
      final rule = MinValue(10);
      expect(rule.validate('9'), isNotNull);
      expect(rule.validate('10'), isNull);
    });

    test('supports exclusive lower bound', () {
      final rule = MinValue(10, inclusive: false);
      expect(rule.validate('10'), isNotNull);
      expect(rule.validate('11'), isNull);
    });
  });
}

