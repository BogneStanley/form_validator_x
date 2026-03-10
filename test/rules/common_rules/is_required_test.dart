import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/is_required.dart';

void main() {
  group('IsRequired', () {
    test('returns null when value is non-empty', () {
      final rule = IsRequired();
      expect(rule.validate('hello'), isNull);
    });

    test('returns error when value is null or empty', () {
      final rule = IsRequired();
      expect(rule.validate(null), isNotNull);
      expect(rule.validate('   '), isNotNull);
    });
  });
}

