import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a numeric value is between two bounds.
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent numeric values (e.g. age must be between 18 and 65).
///
/// Examples:
/// ```dart
/// IsNumBetween(18, 65); // inclusive by default
/// IsNumBetween(0, 1, inclusive: false); // 0 < value < 1
/// ```
class IsNumBetween implements RuleContract {
  static const String _defaultMessage = 'Value is out of range';

  /// Minimum allowed numeric value.
  final double min;

  /// Maximum allowed numeric value.
  final double max;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `>= min` and `<= max`.
  /// When `false`, value must be `> min` and `< max`.
  final bool inclusive;

  const IsNumBetween(
    this.min,
    this.max, {
    this.message,
    this.inclusive = true,
  }) : assert(min <= max, 'min must be <= max');

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    final input = value.trim();
    final parsed = double.tryParse(input);

    if (parsed == null) {
      return _effectiveMessage;
    }

    final isValid = inclusive
        ? (parsed >= min && parsed <= max)
        : (parsed > min && parsed < max);

    return isValid ? null : _effectiveMessage;
  }
}
