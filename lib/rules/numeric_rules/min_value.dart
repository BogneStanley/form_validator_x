import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a numeric value is greater than or equal
/// to a given minimum.
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent numeric values (age, quantity, price, etc.).
///
/// Examples:
/// ```dart
/// MinValue(18); // value >= 18
/// MinValue(0, inclusive: false, message: 'Must be strictly positive');
/// ```
class MinValue implements RuleContract {
  static const String _defaultMessage = 'Value is too small';

  /// Minimum allowed numeric value.
  final double min;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `>= min`. When `false`, value must be `> min`.
  final bool inclusive;

  const MinValue(
    this.min, {
    this.message,
    this.inclusive = true,
  });

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

    final isValid =
        inclusive ? parsed >= min : parsed > min;

    return isValid ? null : _effectiveMessage;
  }
}
