import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a text value has at least a minimum length.
///
/// This rule is typically used with `TextFormField` or `TextField` for
/// fields like password, username, or description where a minimum number
/// of characters is required.
///
/// Examples:
/// ```dart
/// MinLength(8);
/// MinLength(3, message: 'At least 3 characters required');
/// ```
class MinLength implements RuleContract {
  static const String _defaultMessage = 'Value is too short';

  /// Minimum required number of characters.
  final int min;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  const MinLength(this.min, {this.message});

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    if (value.length < min) {
      return _effectiveMessage;
    }

    return null;
  }
}
