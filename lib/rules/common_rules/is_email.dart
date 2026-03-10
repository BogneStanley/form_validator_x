import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a value is a valid email address.
///
/// This rule is typically used for `TextFormField` or `TextField` inputs
/// where the user is expected to enter an email address.
///
/// Examples:
/// ```dart
/// IsEmail();
/// IsEmail(message: 'Please enter a valid email');
/// ```
class IsEmail implements RuleContract {
  static const String _defaultMessage = 'Invalid email address';

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// Basic email pattern that should work for most common cases.
  static final RegExp _emailRegex =
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  const IsEmail({this.message});

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    final input = value.trim();
    return _emailRegex.hasMatch(input) ? null : _effectiveMessage;
  }
}
