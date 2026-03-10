import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_x/rules/common_rules/is_email.dart';

void main() {
  group('IsEmail', () {
    test('accepts valid emails', () {
      final validEmails = [
        'test@example.com',
        'test@example.com.br',
        'test@example.com.br.br',
        'test+test@example.com',
      ];

      for (final email in validEmails) {
        final rule = IsEmail();
        expect(rule.validate(email), isNull, reason: 'Should accept $email');
      }
    });

    test('rejects invalid emails', () {
      final invalidEmails = [
        'not-an-email',
        'not-an-email@example',
        'not-an-email@',
        'not-an@email@example.com.br',
      ];

      for (final email in invalidEmails) {
        final rule = IsEmail();
        expect(rule.validate(email), isNotNull, reason: 'Should reject $email');
      }
    });
  });
}
