import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/max_value.dart';

void main() {
  group('MaxValue', () {
    test('enforces upper bound inclusively by default', () {
      final rule = MaxValue(10);
      expect(rule.validate('11'), isNotNull);
      expect(rule.validate('10'), isNull);
    });

    test('supports exclusive upper bound', () {
      final rule = MaxValue(10, inclusive: false);
      expect(rule.validate('10'), isNotNull);
      expect(rule.validate('9'), isNull);
    });
  });
}

