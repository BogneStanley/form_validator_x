import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/date_rules/is_date.dart';

void main() {
  group('IsDate', () {
    test('accepts valid date', () {
      final rule = IsDate();
      expect(rule.validate('2024-01-01'), isNull);
    });

    test('rejects invalid date', () {
      final rule = IsDate();
      expect(rule.validate('not-a-date'), isNotNull);
    });
  });
}

