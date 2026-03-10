import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a date value is between two bounds.
///
/// The input is parsed using `DateTime.tryParse`, so it should be in a format
/// supported by `DateTime.parse` (e.g. ISO-8601 `yyyy-MM-dd`).
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent date range inputs such as booking periods, validity ranges, etc.
///
/// Examples:
/// ```dart
/// IsDateBetween(
///   minDate: DateTime(2000, 1, 1),
///   maxDate: DateTime(2100, 1, 1),
/// );
/// IsDateBetween(
///   minDate: DateTime.now(),
///   maxDate: DateTime.now().add(const Duration(days: 30)),
///   inclusive: false,
///   message: 'Date must be within the next 30 days',
/// );
/// ```
class IsDateBetween implements RuleContract {
  static const String _defaultMessage = 'Date is out of range';

  /// Minimum allowed date.
  final DateTime minDate;

  /// Maximum allowed date.
  final DateTime maxDate;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `>= minDate` and `<= maxDate`.
  /// When `false`, value must be `> minDate` and `< maxDate`.
  final bool inclusive;

  IsDateBetween({
    required this.minDate,
    required this.maxDate,
    this.message,
    this.inclusive = true,
  }) : assert(minDate.isBefore(maxDate) || minDate.isAtSameMomentAs(maxDate),
            'minDate must be before or equal to maxDate');

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

    final isValid = inclusive
        ? (!parsed.isBefore(minDate) && !parsed.isAfter(maxDate))
        : (parsed.isAfter(minDate) && parsed.isBefore(maxDate));

    return isValid ? null : _effectiveMessage;
  }
}
