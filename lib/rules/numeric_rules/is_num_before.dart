import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a numeric value is before (less than)
/// a given maximum.
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent numeric values (e.g. age, price, quantity).
///
/// Examples:
/// ```dart
/// IsNumBefore(100); // value < 100 if inclusive is false
/// IsNumBefore(100, inclusive: true); // value <= 100
/// ```
class IsNumBefore implements RuleContract {
  static const String _defaultMessage = 'Value is too large';

  /// Maximum numeric value that the input must be before.
  final double max;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `<= max`. When `false`, value must be `< max`.
  final bool inclusive;

  const IsNumBefore(
    this.max, {
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
    final parsed = double.tryParse(input);

    if (parsed == null) {
      return _effectiveMessage;
    }

    final isValid =
        inclusive ? parsed <= max : parsed < max;

    return isValid ? null : _effectiveMessage;
  }
}
