import 'package:form_validator_x/rules/rule_contract.dart';

/// Validation rule to check if the value matches the given pattern.
/// Example:
/// IsPattern(pattern: r'^[a-zA-Z0-9]+$', message: 'Value must be alphanumeric');
/// IsPattern(pattern: r'^[a-zA-Z0-9]+$', message: 'Value must be alphanumeric', isRequired: true);
class IsPattern implements RuleContract {
  static const String _defaultMessage = 'Invalid format';

  /// The pattern to match the value against.
  final String pattern;
  /// Custom message returned when validation fails.
  /// If null, an internal default message is used.
  final String? message;

  /// Whether a null/empty value should be considered invalid.
  final bool isRequired;
  /// The regular expression to match the value against.
  final RegExp _regex;

  /// Constructor for the IsPattern rule.
  /// Example:
  /// IsPattern(pattern: r'^[a-zA-Z0-9]+$', message: 'Value must be alphanumeric');
  /// IsPattern(pattern: r'^[a-zA-Z0-9]+$', message: 'Value must be alphanumeric', isRequired: true);
  IsPattern({
    required this.pattern,
    this.message,
    this.isRequired = false,
  }) : _regex = RegExp(pattern);

  String get _effectiveMessage => message ?? _defaultMessage;

  /// Validates the value against the pattern.
  /// Returns the message if the value does not match the pattern.
  /// Returns null if the value matches the pattern or is null.
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return isRequired ? _effectiveMessage : null;
    }
    return _regex.hasMatch(value) ? null : _effectiveMessage;
  }
}