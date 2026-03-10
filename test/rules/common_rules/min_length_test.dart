import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/min_length.dart';

void main() {
  group('MinLength', () {
    test('fails when value is too short', () {
      final rule = MinLength(3);
      expect(rule.validate('ab'), isNotNull);
    });

    test('passes when value length is sufficient', () {
      final rule = MinLength(3);
      expect(rule.validate('abc'), isNull);
    });
  });
}
