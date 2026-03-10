import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a numeric value is less than or equal
/// to a given maximum.
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent numeric values (age, quantity, price, etc.).
///
/// Examples:
/// ```dart
/// MaxValue(100); // value <= 100
/// MaxValue(0, inclusive: false, message: 'Must be strictly negative');
/// ```
class MaxValue implements RuleContract {
  static const String _defaultMessage = 'Value is too large';

  /// Maximum allowed numeric value.
  final double max;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `<= max`. When `false`, value must be `< max`.
  final bool inclusive;

  const MaxValue(
    this.max, {
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
        inclusive ? parsed <= max : parsed < max;

    return isValid ? null : _effectiveMessage;
  }
}
