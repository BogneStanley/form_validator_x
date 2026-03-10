import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a value is provided (non-null and non-empty).
/// Example:
/// IsRequired(message: 'This field is required');
class IsRequired implements RuleContract {
  static const String _defaultMessage = 'This field is required';

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// Constructor for the IsRequired rule.
  /// Example:
  /// IsRequired(message: 'This field is required');
  const IsRequired({
    this.message,
  });

  String get _effectiveMessage => message ?? _defaultMessage;

  /// Validates that the value is not null and not empty (after trimming).
  /// Returns the message if the value is null or empty.
  /// Returns null if the value is present.
  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _effectiveMessage;
    }
    return null;
  }
}
