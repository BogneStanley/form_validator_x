import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a value is numeric.
///
/// This rule is typically used for `TextFormField` or `TextField` values
/// representing numbers such as age, price, quantity, etc.
///
/// Examples:
/// ```dart
/// // Accepts any number
/// IsNumeric();
///
/// // Accepts only integers
/// IsNumeric(isInt: true, message: 'Must be a whole number');
///
/// // Accepts only doubles
/// IsNumeric(isDouble: true, message: 'Must be a decimal number');
/// ```
class IsNumeric implements RuleContract {
  static const String _defaultMessage = 'Value must be numeric';

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, the value must be a valid `int`.
  final bool isInt;

  /// When `true`, the value must be a valid `double`.
  final bool isDouble;

  const IsNumeric({
    this.message,
    this.isInt = false,
    this.isDouble = false,
  });

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    final input = value.trim();

    if (isInt) {
      return int.tryParse(input) == null ? _effectiveMessage : null;
    }

    if (isDouble) {
      return double.tryParse(input) == null ? _effectiveMessage : null;
    }

    // Default: accept any number
    return num.tryParse(input) == null ? _effectiveMessage : null;
  }
}
