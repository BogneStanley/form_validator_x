import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/numeric_rules/is_numeric.dart';

void main() {
  group('IsNumeric', () {
    test('accepts integers and doubles by default', () {
      final rule = IsNumeric();
      expect(rule.validate('123'), isNull);
      expect(rule.validate('123.45'), isNull);
    });

    test('accepts only int when isInt is true', () {
      final rule = IsNumeric(isInt: true);
      expect(rule.validate('123'), isNull);
      expect(rule.validate('123.45'), isNotNull);
    });


    test('accepts only double when isDouble is true', () {
      final rule = IsNumeric(isDouble: true);
      expect(rule.validate('123.45'), isNull);
      expect(rule.validate('123'), isNull);
    });
  });
}

