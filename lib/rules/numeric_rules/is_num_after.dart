import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a numeric value is after (greater than)
/// a given minimum.
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent numeric values (e.g. age, price, quantity).
///
/// Examples:
/// ```dart
/// IsNumAfter(0); // value > 0 if inclusive is false
/// IsNumAfter(0, inclusive: true); // value >= 0
/// ```
class IsNumAfter implements RuleContract {
  static const String _defaultMessage = 'Value is too small';

  /// Minimum numeric value that the input must be after.
  final num min;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, value must be `>= min`. When `false`, value must be `> min`.
  final bool inclusive;

  const IsNumAfter(
    this.min, {
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
    final parsed = num.tryParse(input);

    if (parsed == null) {
      return _effectiveMessage;
    }

    final isValid =
        inclusive ? parsed >= min : parsed > min;

    return isValid ? null : _effectiveMessage;
  }
}
