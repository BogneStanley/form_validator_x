import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to ensure that a value is a valid date string.
///
/// The value is parsed using `DateTime.tryParse`, so it should be in a format
/// supported by `DateTime.parse`, such as ISO-8601 (`yyyy-MM-dd` or
/// `yyyy-MM-ddTHH:mm:ss`).
///
/// This rule is typically used with `TextFormField` or `TextField` that
/// represent date inputs (e.g. birthdate, booking date).
///
/// Examples:
/// ```dart
/// IsDate();
/// IsDate(message: 'Invalid date format');
/// ```
class IsDate implements RuleContract {
  static const String _defaultMessage = 'Invalid date';

  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  const IsDate({this.message});

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Use [IsRequired] to enforce non-empty values.
      return null;
    }

    final input = value.trim();
    final parsed = DateTime.tryParse(input);

    return parsed == null ? _effectiveMessage : null;
  }
}
