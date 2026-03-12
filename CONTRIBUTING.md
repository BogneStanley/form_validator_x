# Contributing to form_validator_x

Thank you for considering contributing to **form_validator_x**! This is an open-source Flutter package and contributions of all kinds are welcome — bug reports, feature suggestions, documentation improvements, and pull requests.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [How to Contribute](#how-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Submitting a Pull Request](#submitting-a-pull-request)
- [Adding a New Validation Rule](#adding-a-new-validation-rule)
- [Writing Tests](#writing-tests)
- [Code Style](#code-style)
- [Commit Convention](#commit-convention)

---

## Code of Conduct

By participating in this project, you agree to be respectful and constructive. We are committed to providing a welcoming environment for everyone, regardless of experience level, background, or identity.

---

## Getting Started

### Prerequisites

- Flutter SDK `>=1.17.0`
- Dart SDK `^3.8.1`

### Local Setup

```bash
# 1. Fork the repository and clone your fork
git clone https://github.com/<your-username>/form_validator_x.git
cd form_validator_x

# 2. Install dependencies
flutter pub get

# 3. Run the existing tests to make sure everything passes
flutter test
```

### Run the example app

```bash
cd example
flutter pub get
flutter run
```

---

## Project Structure

```
form_validator_x/
├── lib/
│   ├── form_validator_x.dart          # Main library entry point & exports
│   └── rules/
│       ├── rule_contract.dart         # RuleContract interface
│       ├── common_rules/              # Text & string validation rules
│       │   ├── common_rules.dart      # Barrel export
│       │   ├── is_email.dart
│       │   ├── is_equals.dart
│       │   ├── is_pattern.dart
│       │   ├── is_required.dart
│       │   ├── max_length.dart
│       │   ├── min_length.dart
│       │   └── must_containt.dart
│       ├── date_rules/                # Date validation rules
│       │   ├── date_rules.dart        # Barrel export
│       │   ├── is_date.dart
│       │   ├── is_date_after.dart
│       │   ├── is_date_before.dart
│       │   └── is_date_between.dart
│       └── numeric_rules/             # Numeric validation rules
│           ├── numeric_rules.dart     # Barrel export
│           ├── is_num_after.dart
│           ├── is_num_before.dart
│           ├── is_num_between.dart
│           ├── is_numeric.dart
│           ├── max_value.dart
│           └── min_value.dart
├── test/
│   └── form_validator_x_test.dart     # Unit tests
├── example/
│   └── lib/main.dart                  # Example Flutter app
├── pubspec.yaml
├── README.md
└── CONTRIBUTING.md
```

---

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue and include:

- A clear and descriptive title
- Steps to reproduce the problem
- Expected behavior vs. actual behavior
- Your Flutter/Dart SDK version (`flutter --version`)
- A minimal code snippet that reproduces the issue

### Suggesting Features

Feature requests are welcome! Open an issue with:

- A clear description of the proposed feature
- The use case that motivates it
- Any API design ideas you have in mind

### Submitting a Pull Request

1. **Fork** the repository and create a branch from `main`:

   ```bash
   git checkout -b feat/my-new-rule
   ```

2. **Make your changes**, following the code style and conventions described below.

3. **Add tests** for your changes (see [Writing Tests](#writing-tests)).

4. **Run tests** locally to ensure nothing is broken:

   ```bash
   flutter test
   ```

5. **Commit** your changes following the [commit convention](#commit-convention).

6. **Push** and open a Pull Request against the `main` branch.

7. Fill in the PR template:
   - What does this PR change?
   - Why is this change needed?
   - Link to the related issue (if any)

> All PRs require at least one reviewer approval before merging.

---

## Adding a New Validation Rule

New rules should follow the pattern already established in the codebase.

### Step-by-step

**1. Create the rule file** in the appropriate sub-folder:

- String/text → `lib/rules/common_rules/`
- Date → `lib/rules/date_rules/`
- Numeric → `lib/rules/numeric_rules/`
- Or create a new sub-folder if needed.

**2. Implement `RuleContract`:**

```dart
import 'package:form_validator_x/rules/rule_contract.dart';

/// [Short Dart doc explaining what this rule does.]
///
/// Examples:
/// ```dart
/// MyNewRule();
/// MyNewRule(message: 'Custom error message');
/// ```
class MyNewRule implements RuleContract {
  static const String _defaultMessage = 'Your default error message';

  /// Custom message returned when validation fails.
  /// If null, the default message is used.
  final String? message;

  const MyNewRule({this.message});

  String get _effectiveMessage => message ?? _defaultMessage;

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      // Return null for empty values — pair with IsRequired if needed.
      return null;
    }

    // ... your validation logic ...

    return isValid ? null : _effectiveMessage;
  }
}
```

**3. Export the rule** from its barrel file:

```dart
// e.g. lib/rules/common_rules/common_rules.dart
export 'my_new_rule.dart';
```

> The main `lib/form_validator_x.dart` already exports all barrel files, so your rule will be available to users automatically.

**4. Write tests** (see below).

**5. Document it** in `README.md` under the appropriate section.

---

## Writing Tests

All validation rules must have corresponding unit tests in `test/form_validator_x_test.dart`.

### Checklist for a new rule's tests

| Scenario | Expected result |
|----------|----------------|
| `null` value | `null` (valid — use IsRequired separately) |
| Empty string | `null` (valid — use IsRequired separately) |
| Valid value | `null` |
| Invalid value | Non-null error message |
| Custom `message` | Returns the custom message string |
| Edge cases (e.g. boundaries for range rules) | Both sides of the boundary tested |

### Example

```dart
group('MyNewRule', () {
  test('should pass for null', () {
    expect(FormValidatorX(value: null).validate(rules: [MyNewRule()]), isNull);
  });

  test('should pass for empty string', () {
    expect(FormValidatorX(value: '').validate(rules: [MyNewRule()]), isNull);
  });

  test('should pass for valid value', () {
    expect(FormValidatorX(value: 'valid').validate(rules: [MyNewRule()]), isNull);
  });

  test('should fail for invalid value', () {
    expect(FormValidatorX(value: 'invalid').validate(rules: [MyNewRule()]), isNotNull);
  });

  test('should return custom message on failure', () {
    expect(
      FormValidatorX(value: 'invalid').validate(
        rules: [MyNewRule(message: 'Custom error')],
      ),
      equals('Custom error'),
    );
  });
});
```

Run tests with:

```bash
flutter test
```

---

## Code Style

This project follows standard Dart/Flutter code style enforced by `flutter_lints`.

- Use `const` constructors wherever possible.
- Prefer named parameters for constructors with more than one argument.
- Write Dart doc comments (`///`) for every public class and parameter.
- Avoid abbreviations in variable names — prefer `_effectiveMessage` over `_msg`.
- Run the linter before pushing:

  ```bash
  flutter analyze
  ```

---

## Commit Convention

This project uses **[Conventional Commits](https://www.conventionalcommits.org/)**.

### Format

```
<type>(<scope>): <short description>

[optional body]

[optional footer]
```

### Types

| Type | Use when |
|------|----------|
| `feat` | Adding a new validation rule or feature |
| `fix` | Fixing a bug in an existing rule |
| `docs` | Updating README, CONTRIBUTING, or doc comments |
| `test` | Adding or updating tests |
| `refactor` | Code changes that neither add features nor fix bugs |
| `chore` | Maintenance tasks (dependency updates, CI config, etc.) |

### Examples

```
feat(date_rules): add IsDateBetween rule with inclusive option

fix(common_rules): IsEmail now trims whitespace before validation

docs: add full rules reference to README

test(numeric_rules): add edge case tests for IsNumBetween bounds
```

---

Thank you for helping make **form_validator_x** better! ❤️🎉
