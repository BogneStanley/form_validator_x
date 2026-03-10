import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/must_containt.dart';

void main() {
  group('MustContain', () {
    test('passes when substring is present', () {
      final rule = MustContain('@');
      expect(rule.validate('user@example.com'), isNull);
    });

    test('fails when substring is missing', () {
      final rule = MustContain('@');
      expect(rule.validate('userexample.com'), isNotNull);
    });

    test('respects case sensitivity', () {
      final rule = MustContain('abc', caseSensitive: false);
      expect(rule.validate('ABC'), isNull);
    });
  });
}

