import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/date_rules/is_date_before.dart';

void main() {
  group('IsDateBefore', () {
    test('enforces strictly before by default', () {
      final max = DateTime(2020, 1, 1);
      final rule = IsDateBefore(maxDate: max);
      expect(rule.validate('2020-01-01'), isNotNull);
      expect(rule.validate('2019-12-31'), isNull);
    });

    test('supports inclusive before-or-equal', () {
      final max = DateTime(2020, 1, 1);
      final rule = IsDateBefore(maxDate: max, inclusive: true);
      expect(rule.validate('2020-01-01'), isNull);
    });
  });
}

