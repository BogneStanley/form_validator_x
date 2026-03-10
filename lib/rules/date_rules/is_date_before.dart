import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a date value is before a given maximum date.
///
/// The input is parsed using `DateTime.tryParse`, so it should be in a format
/// supported by `DateTime.parse` (e.g. ISO-8601 `yyyy-MM-dd`).
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent date inputs such as end date, expiration date, etc.
///
/// Examples:
/// ```dart
/// IsDateBefore(
///   maxDate: DateTime(2100, 1, 1),
/// );
/// IsDateBefore(
///   maxDate: DateTime.now(),
///   inclusive: true,
///   message: 'Date must be today or earlier',
/// );
/// ```
class IsDateBefore implements RuleContract {
  static const String _defaultMessage = 'Date is too late';

  /// Maximum allowed date.
  final DateTime maxDate;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be on or before [maxDate].
  /// When `false`, value must be strictly before [maxDate].
  final bool inclusive;

  const IsDateBefore({
    required this.maxDate,
    this.message,
    this.inclusive = false,
  });

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    final input = value.trim();
    final parsed = DateTime.tryParse(input);

    if (parsed == null) {
      return _effectiveMessage;
    }

    final isValid =
        inclusive ? !parsed.isAfter(maxDate) : parsed.isBefore(maxDate);

    return isValid ? null : _effectiveMessage;
  }
}
