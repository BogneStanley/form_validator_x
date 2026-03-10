import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/is_pattern.dart';

void main() {
  group('IsPattern', () {
    test('returns null when value matches pattern', () {
      final rule = IsPattern(pattern: r'^[a-z]+$');
      expect(rule.validate('abc'), isNull);
    });

    test('returns error when value does not match pattern', () {
      final rule = IsPattern(pattern: r'^[a-z]+$');
      expect(rule.validate('abc123'), isNotNull);
    });

    test('treats empty as valid when not required', () {
      final rule = IsPattern(pattern: r'^[a-z]+$');
      expect(rule.validate(''), isNull);
      expect(rule.validate(null), isNull);
    });

    test('treats empty as invalid when required', () {
      final rule = IsPattern(pattern: r'^[a-z]+$', isRequired: true);
      expect(rule.validate(''), isNotNull);
      expect(rule.validate(null), isNotNull);
    });
  });
}

