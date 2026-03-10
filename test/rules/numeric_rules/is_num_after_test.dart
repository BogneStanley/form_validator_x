import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/is_num_after.dart';

void main() {
  group('IsNumAfter', () {
    test('enforces strict greater-than by default', () {
      final rule = IsNumAfter(10);
      expect(rule.validate('10'), isNotNull);
      expect(rule.validate('11'), isNull);
    });

    test('supports inclusive greater-or-equal', () {
      final rule = IsNumAfter(10, inclusive: true);
      expect(rule.validate('10'), isNull);
    });
  });
}

