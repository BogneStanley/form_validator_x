import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/date_rules/is_date_after.dart';

void main() {
  group('IsDateAfter', () {
    test('enforces strictly after by default', () {
      final min = DateTime(2020, 1, 1);
      final rule = IsDateAfter(minDate: min);
      expect(rule.validate('2020-01-01'), isNotNull);
      expect(rule.validate('2020-01-02'), isNull);
    });

    test('supports inclusive after-or-equal', () {
      final min = DateTime(2020, 1, 1);
      final rule = IsDateAfter(minDate: min, inclusive: true);
      expect(rule.validate('2020-01-01'), isNull);
    });
  });
}

