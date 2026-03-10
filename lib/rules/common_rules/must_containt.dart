import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a text value contains a given substring.
///
/// This rule is typically used with `TextFormField` or `TextField` for
/// constraints like "password must contain a special character", or
/// "text must contain a specific keyword".
///
/// Examples:
/// ```dart
/// MustContain('@'); // e.g. for enforcing '@' in a username
/// MustContain('#', message: 'Must contain #hashtag');
/// MustContain('abc', caseSensitive: false);
/// ```
class MustContain implements RuleContract {
  static const String _defaultMessage = 'Value does not contain required text';

  /// The substring that must be present in the value.
  final String substring;

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// Whether the match should be case sensitive.
  final bool caseSensitive;

  const MustContain(
    this.substring, {
    this.message,
    this.caseSensitive = true,
  });

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    if (substring.isEmpty) {
      // Nothing to enforce.
      return null;
    }

    String haystack = value;
    String needle = substring;

    if (!caseSensitive) {
      haystack = haystack.toLowerCase();
      needle = needle.toLowerCase();
    }

    return haystack.contains(needle) ? null : _effectiveMessage;
  }
}
