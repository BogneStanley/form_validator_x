import 'package:flutter_test/flutter_test.dart';

import 'package:form_validator_x/form_validator_x.dart';


void main() {
  group('FormValidatorX', () {
    test('should return null when value is not null and no rules are provided', () {
      final formValidator = FormValidatorX(value: 'test');
      final result = formValidator.validate();
      expect(result, isNull);
    });

    test('should return null when value is null and no rules are provided', () {
      final formValidator = FormValidatorX(value: null);
      final result = formValidator.validate();
      expect(result, isNull);
    });

    test('should return not null when value is invalid and rules are provided', () {
      final formValidator = FormValidatorX(value: 'testexample.com');
      final result = formValidator.validate(rules: [IsEmail()]);
      expect(result, isNotNull);
    });

    test('should return null when value is valid and rules are provided', () {
      final formValidator = FormValidatorX(value: 'test@example.com');
      final result = formValidator.validate(rules: [IsEmail()]);
      expect(result, isNull);
    });

    test('should return not null when value is invalid and multiple rules are provided', () {
      final formValidator = FormValidatorX(value: 'test@exampl.com');
      final result = formValidator.validate(rules: [IsEmail(), IsRequired(), IsEquals(other: "test@example.com")]);
      expect(result, isNotNull);
    });

    test('should return null when value is valid and multiple rules are provided', () {
      final formValidator = FormValidatorX(value: 'test@example.com');
      final result = formValidator.validate(rules: [IsEmail(), IsRequired(), IsEquals(other: "test@example.com")]);
      expect(result, isNull);
    });

    // Date
    group('Date Rules', () {
      test('IsDate should validate correct date formats', () {
        final v1 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDate()]);
        expect(v1, isNull);

        final v2 = FormValidatorX(value: 'invalid').validate(rules: [IsDate()]);
        expect(v2, equals('Invalid date'));
      });

      test('IsDateAfter should validate date is after minDate', () {
        final minDate = DateTime(2023, 10, 27);
        
        final v1 = FormValidatorX(value: '2023-10-28').validate(rules: [IsDateAfter(minDate: minDate)]);
        expect(v1, isNull);

        final v2 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDateAfter(minDate: minDate)]);
        expect(v2, equals('Date is too early'));

        final v3 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDateAfter(minDate: minDate, inclusive: true)]);
        expect(v3, isNull);

        final v4 = FormValidatorX(value: '2023-10-26').validate(rules: [IsDateAfter(minDate: minDate)]);
        expect(v4, equals('Date is too early'));
      });

      test('IsDateBefore should validate date is before maxDate', () {
        final maxDate = DateTime(2023, 10, 27);

        final v1 = FormValidatorX(value: '2023-10-26').validate(rules: [IsDateBefore(maxDate: maxDate)]);
        expect(v1, isNull);

        final v2 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDateBefore(maxDate: maxDate)]);
        expect(v2, equals('Date is too late'));

        final v3 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDateBefore(maxDate: maxDate, inclusive: true)]);
        expect(v3, isNull);

        final v4 = FormValidatorX(value: '2023-10-28').validate(rules: [IsDateBefore(maxDate: maxDate)]);
        expect(v4, equals('Date is too late'));
      });

      test('IsDateBetween should validate date is within range', () {
        final minDate = DateTime(2023, 10, 25);
        final maxDate = DateTime(2023, 10, 30);

        final v1 = FormValidatorX(value: '2023-10-27').validate(rules: [IsDateBetween(minDate: minDate, maxDate: maxDate)]);
        expect(v1, isNull);

        final v2 = FormValidatorX(value: '2023-10-25').validate(rules: [IsDateBetween(minDate: minDate, maxDate: maxDate)]);
        expect(v2, isNull);

        final v3 = FormValidatorX(value: '2023-10-25').validate(rules: [IsDateBetween(minDate: minDate, maxDate: maxDate, inclusive: false)]);
        expect(v3, equals('Date is out of range'));

        final v4 = FormValidatorX(value: '2023-10-20').validate(rules: [IsDateBetween(minDate: minDate, maxDate: maxDate)]);
        expect(v4, equals('Date is out of range'));
      });
    });
    
  });
}
