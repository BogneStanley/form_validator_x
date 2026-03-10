import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a date value is after a given minimum date.
///
/// The input is parsed using `DateTime.tryParse`, so it should be in a format
/// supported by `DateTime.parse` (e.g. ISO-8601 `yyyy-MM-dd`).
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent date inputs such as start date, booking date, etc.
///
/// Examples:
/// ```dart
/// IsDateAfter(
///   minDate: DateTime(2000, 1, 1),
/// );
/// IsDateAfter(
///   minDate: DateTime.now(),
///   inclusive: true,
///   message: 'Date must be today or later',
/// );
/// ```
class IsDateAfter implements RuleContract {
  static const String _defaultMessage = 'Date is too early';

  /// Minimum allowed date.
  final DateTime minDate;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be on or after [minDate].
  /// When `false`, value must be strictly after [minDate].
  final bool inclusive;

  const IsDateAfter({
    required this.minDate,
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
        inclusive ? !parsed.isBefore(minDate) : parsed.isAfter(minDate);

    return isValid ? null : _effectiveMessage;
  }
}
