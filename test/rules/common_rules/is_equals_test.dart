import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/is_equals.dart';

void main() {
  group('IsEquals', () {
    test('returns null when values are equal', () {
      final rule = IsEquals(other: 'abc');
      expect(rule.validate('abc'), isNull);
    });

    test('returns error when values are different', () {
      final rule = IsEquals(other: 'abc');
      expect(rule.validate('xyz'), isNotNull);
    });

    test('ignores case when ignoreCase is true', () {
      final rule = IsEquals(other: 'AbC', ignoreCase: true);
      expect(rule.validate('abc'), isNull);
    });
  });
}

