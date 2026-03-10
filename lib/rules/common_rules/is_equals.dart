import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a value equals another value.
///
/// This rule is typically used for confirmation fields, for example
/// confirming a password or email address in a `TextFormField`.
///
/// Examples:
/// ```dart
/// IsEquals(other: 'SECRET');
/// IsEquals(
///   other: password,
///   message: 'Passwords do not match',
/// );
/// IsEquals(
///   other: email,
///   ignoreCase: true,
/// );
/// ```
class IsEquals implements RuleContract {
  static const String _defaultMessage = 'Values do not match';

  /// The value that the input should be equal to.
  final String other;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// When `true`, comparison is done in a case-insensitive way.
  final bool ignoreCase;

  const IsEquals({
    required this.other,
    this.message,
    this.ignoreCase = false,
  });

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      // Use [IsRequired] on the field if it must not be empty.
      return null;
    }

    String a = value;
    String b = other;

    if (ignoreCase) {
      a = a.toLowerCase();
      b = b.toLowerCase();
    }

    return a == b ? null : _effectiveMessage;
  }
}
