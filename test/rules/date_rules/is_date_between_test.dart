import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/date_rules/is_date_between.dart';

void main() {
  group('IsDateBetween', () {
    test('enforces inclusive bounds by default', () {
      final min = DateTime(2020, 1, 1);
      final max = DateTime(2020, 12, 31);
      final rule = IsDateBetween(
        minDate: min,
        maxDate: max,
        inclusive: true,
      );
      expect(rule.validate('2019-12-31'), isNotNull);
      expect(rule.validate('2020-01-01'), isNull);
      expect(rule.validate('2020-12-31'), isNull);
      expect(rule.validate('2021-01-01'), isNotNull);
    });

    test('supports exclusive bounds', () {
      final min = DateTime(2020, 1, 1);
      final max = DateTime(2020, 12, 31);
      final rule = IsDateBetween(
        minDate: min,
        maxDate: max,
        inclusive: false,
      );
      expect(rule.validate('2020-01-01'), isNotNull);
      expect(rule.validate('2020-01-02'), isNull);
      expect(rule.validate('2020-12-31'), isNotNull);
    });
  });
}

