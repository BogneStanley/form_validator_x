import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/max_length.dart';

void main() {
  group('MaxLength', () {
    test('fails when value is too long', () {
      final rule = MaxLength(3);
      expect(rule.validate('abcd'), isNotNull);
    });

    test('passes when value length is within limit', () {
      final rule = MaxLength(3);
      expect(rule.validate('abc'), isNull);
    });
  });
}

