import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/is_num_before.dart';

void main() {
  group('IsNumBefore', () {
    test('enforces strict less-than by default', () {
      final rule = IsNumBefore(10);
      expect(rule.validate('10'), isNotNull);
      expect(rule.validate('9'), isNull);
    });

    test('supports inclusive less-or-equal', () {
      final rule = IsNumBefore(10, inclusive: true);
      expect(rule.validate('10'), isNull);
    });
  });
}

