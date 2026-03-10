import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/is_num_between.dart';

void main() {
  group('IsNumBetween', () {
    test('enforces inclusive bounds by default', () {
      final rule = IsNumBetween(10, 20);
      expect(rule.validate('9'), isNotNull);
      expect(rule.validate('10'), isNull);
      expect(rule.validate('20'), isNull);
      expect(rule.validate('21'), isNotNull);
    });

    test('supports exclusive bounds', () {
      final rule = IsNumBetween(10, 20, inclusive: false);
      expect(rule.validate('10'), isNotNull);
      expect(rule.validate('11'), isNull);
      expect(rule.validate('20'), isNotNull);
    });
  });
}

