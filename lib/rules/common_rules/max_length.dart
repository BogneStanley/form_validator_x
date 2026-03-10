import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a text value does not exceed a maximum length.
///
/// This rule is typically used with `TextFormField` or `TextField` where
/// you want to restrict the number of characters a user can input.
///
/// Examples:
/// ```dart
/// MaxLength(20);
/// MaxLength(50, message: 'Maximum 50 characters allowed');
/// ```
class MaxLength implements RuleContract {
  static const String _defaultMessage = 'Value is too long';

  /// Maximum allowed number of characters.
  final int max;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  const MaxLength(this.max, {this.message});

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null) {
      // Use [IsRequired] to enforce non-null values.
      return null;
    }

    if (value.length > max) {
      return _effectiveMessage;
    }

    return null;
  }
}
