# form_validator_x

A flexible and composable form validation library for Flutter. Define validation rules as simple, reusable objects and chain them together on any `TextFormField`.

---

## Features

- ✅ **Composable** — chain multiple rules on a single field
- ✅ **Zero dependencies** — no external packages required
- ✅ **Customizable messages** — every rule accepts an optional custom error message
- ✅ **Three rule categories** — common, date, and numeric
- ✅ **Null-safe** — fully supports Dart null safety
- ✅ **Extensible** — implement `RuleContract` to create your own rules

---

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Core Concept](#core-concept)
- [Rules Reference](#rules-reference)
  - [Common Rules](#common-rules)
  - [Date Rules](#date-rules)
  - [Numeric Rules](#numeric-rules)
- [Creating a Custom Rule](#creating-a-custom-rule)
- [Full Example](#full-example)
- [Design Philosophy](#design-philosophy)

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  form_validator_x: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## Quick Start

```dart
import 'package:form_validator_x/form_validator_x.dart';

TextFormField(
  validator: (value) => FormValidatorX(value: value).validate(
    rules: [
      IsRequired(message: 'Email is required'),
      IsEmail(message: 'Enter a valid email'),
    ],
  ),
)
```

Pass the `validator` result directly to Flutter's `TextFormField.validator` — it returns `null` when valid, or an error message `String` when invalid.

---

## Core Concept

Everything revolves around two pieces:

### `FormValidatorX`

The main validator class. It wraps the field's current value and runs it through a list of rules in order. It stops at the **first failing rule** and returns its message.

```dart
FormValidatorX(value: value).validate(rules: [...]);
// returns null   → value is valid
// returns String → first validation error message
```

### `RuleContract`

The interface all rules implement:

```dart
abstract class RuleContract {
  String? validate(String? value);
}
```

> **Important:** All built-in rules treat `null` or empty values as **passing** by default — pair them with `IsRequired` when the field is mandatory. This keeps your rules orthogonal and composable.

---

## Rules Reference

### Common Rules

#### `IsRequired`

Ensures the value is not null and not blank (after trimming).

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `'This field is required'` | Custom error message |

```dart
IsRequired()
IsRequired(message: 'Please fill in this field')
```

---

#### `IsEmail`

Validates that the value is a well-formed email address using the pattern `^[^\@\s]+@[^\@\s]+\.[^\@\s]+$`.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `'Invalid email address'` | Custom error message |

```dart
IsEmail()
IsEmail(message: 'Enter a valid email address')
```

---

#### `IsEquals`

Validates that the value equals another given string. Useful for password confirmation fields.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `other` | `String` | *required* | The value to compare against |
| `message` | `String?` | `'Values do not match'` | Custom error message |
| `ignoreCase` | `bool` | `false` | If `true`, comparison is case-insensitive |

```dart
IsEquals(other: passwordController.text)
IsEquals(other: 'SECRET', ignoreCase: true, message: 'Passwords do not match')
```

---

#### `IsPattern`

Validates that the value matches a given regular expression pattern.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `pattern` | `String` | *required* | Regex pattern string |
| `message` | `String?` | `'Invalid format'` | Custom error message |
| `isRequired` | `bool` | `false` | If `true`, empty/null values fail validation |

```dart
IsPattern(pattern: r'^[a-zA-Z0-9]+$', message: 'Only alphanumeric characters allowed')
IsPattern(pattern: r'^\+?[0-9]{7,15}$', message: 'Invalid phone number', isRequired: true)
```

---

#### `MinLength`

Ensures the value has at least a minimum number of characters.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `min` | `int` | *required* | Minimum character count |
| `message` | `String?` | `'Value is too short'` | Custom error message |

```dart
MinLength(8)
MinLength(3, message: 'At least 3 characters required')
```

---

#### `MaxLength`

Ensures the value does not exceed a maximum number of characters.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `max` | `int` | *required* | Maximum character count |
| `message` | `String?` | `'Value is too long'` | Custom error message |

```dart
MaxLength(50)
MaxLength(20, message: 'Maximum 20 characters allowed')
```

---

#### `MustContain`

Validates that the value contains a specific substring.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `substring` | `String` | *required* | The substring that must be present |
| `message` | `String?` | `'Value does not contain required text'` | Custom error message |
| `caseSensitive` | `bool` | `true` | If `false`, match is case-insensitive |

```dart
MustContain('@')
MustContain('#', message: 'Must include a hashtag')
MustContain('flutter', caseSensitive: false)
```

---

### Date Rules

All date rules accept values parseable by `DateTime.tryParse` (e.g. ISO-8601 format: `yyyy-MM-dd` or `yyyy-MM-ddTHH:mm:ss`).

#### `IsDate`

Validates that the value is a parseable date string.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `'Invalid date'` | Custom error message |

```dart
IsDate()
IsDate(message: 'Please enter a valid date')
```

---

#### `IsDateAfter`

Validates that the parsed date is after a given minimum date.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `minDate` | `DateTime` | *required* | The minimum allowed date |
| `message` | `String?` | `'Date is too early'` | Custom error message |
| `inclusive` | `bool` | `false` | If `true`, the value may equal `minDate` |

```dart
// Strictly after 2024-01-01
IsDateAfter(minDate: DateTime(2024, 1, 1))

// On or after today
IsDateAfter(minDate: DateTime.now(), inclusive: true, message: 'Date must be today or later')
```

---

#### `IsDateBefore`

Validates that the parsed date is before a given maximum date.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `maxDate` | `DateTime` | *required* | The maximum allowed date |
| `message` | `String?` | `'Date is too late'` | Custom error message |
| `inclusive` | `bool` | `false` | If `true`, the value may equal `maxDate` |

```dart
// Strictly before 2100-01-01
IsDateBefore(maxDate: DateTime(2100, 1, 1))

// On or before today
IsDateBefore(maxDate: DateTime.now(), inclusive: true, message: 'Date must be today or earlier')
```

---

#### `IsDateBetween`

Validates that the parsed date falls within a range defined by `minDate` and `maxDate`.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `minDate` | `DateTime` | *required* | Lower bound of the range |
| `maxDate` | `DateTime` | *required* | Upper bound of the range |
| `message` | `String?` | `'Date is out of range'` | Custom error message |
| `inclusive` | `bool` | `true` | If `true`, bounds are included (`>=` / `<=`). If `false`, bounds are excluded (`>` / `<`) |

> **Note:** An assertion will throw if `minDate` is after `maxDate`.

```dart
// Inclusive by default
IsDateBetween(
  minDate: DateTime(2020, 1, 1),
  maxDate: DateTime(2030, 12, 31),
)

// Exclusive bounds
IsDateBetween(
  minDate: DateTime.now(),
  maxDate: DateTime.now().add(const Duration(days: 30)),
  inclusive: false,
  message: 'Must be within the next 30 days (exclusive)',
)
```

---

### Numeric Rules

All numeric rules parse the string value as a `num` (or `double` where noted). An unparseable value causes validation to fail.

#### `IsNumeric`

Validates that the value is a valid number. Optionally constrains to `int` or `double`.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `'Value must be numeric'` | Custom error message |
| `isInt` | `bool` | `false` | If `true`, value must parse as an integer |
| `isDouble` | `bool` | `false` | If `true`, value must parse as a double |

```dart
IsNumeric()                                          // any number
IsNumeric(isInt: true, message: 'Must be a whole number')
IsNumeric(isDouble: true, message: 'Must be a decimal number')
```

---

#### `MinValue`

Validates that the numeric value is greater than or equal to a minimum.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `min` | `double` | *required* | Minimum value |
| `message` | `String?` | `'Value is too small'` | Custom error message |
| `inclusive` | `bool` | `true` | If `true`, value must be `>= min`; if `false`, strictly `> min` |

```dart
MinValue(18)                                         // value >= 18
MinValue(0, inclusive: false, message: 'Must be strictly positive')
```

---

#### `MaxValue`

Validates that the numeric value is less than or equal to a maximum.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `max` | `double` | *required* | Maximum value |
| `message` | `String?` | `'Value is too large'` | Custom error message |
| `inclusive` | `bool` | `true` | If `true`, value must be `<= max`; if `false`, strictly `< max` |

```dart
MaxValue(100)                                        // value <= 100
MaxValue(0, inclusive: false, message: 'Must be strictly negative')
```

---

#### `IsNumAfter`

Validates that the numeric value is greater than a given threshold.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `min` | `num` | *required* | The threshold |
| `message` | `String?` | `'Value is too small'` | Custom error message |
| `inclusive` | `bool` | `false` | If `true`, value must be `>= min` |

```dart
IsNumAfter(0)                    // value > 0
IsNumAfter(0, inclusive: true)   // value >= 0
```

---

#### `IsNumBefore`

Validates that the numeric value is less than a given threshold.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `max` | `double` | *required* | The threshold |
| `message` | `String?` | `'Value is too large'` | Custom error message |
| `inclusive` | `bool` | `false` | If `true`, value must be `<= max` |

```dart
IsNumBefore(100)                   // value < 100
IsNumBefore(100, inclusive: true)  // value <= 100
```

---

#### `IsNumBetween`

Validates that the numeric value falls within a range.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `min` | `double` | *required* | Lower bound |
| `max` | `double` | *required* | Upper bound |
| `message` | `String?` | `'Value is out of range'` | Custom error message |
| `inclusive` | `bool` | `true` | If `true`, bounds are included |

> **Note:** An assertion will throw if `min > max`.

```dart
IsNumBetween(18, 65)                       // 18 <= value <= 65
IsNumBetween(0, 1, inclusive: false)       // 0 < value < 1
```

---

## Creating a Custom Rule

Implement `RuleContract` to add your own validation logic:

```dart
import 'package:form_validator_x/form_validator_x.dart';

class IsStrongPassword implements RuleContract {
  final String? message;
  const IsStrongPassword({this.message});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null; // pair with IsRequired

    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    final hasSpecial = value.contains(RegExp(r'[!@#\$%^&*]'));

    if (hasUpper && hasDigit && hasSpecial) return null;
    return message ?? 'Password must contain uppercase, digit, and special character';
  }
}
```

Then use it like any built-in rule:

```dart
TextFormField(
  validator: (value) => FormValidatorX(value: value).validate(
    rules: [
      IsRequired(),
      MinLength(8),
      IsStrongPassword(),
    ],
  ),
)
```

---

## Full Example

The following shows a complete registration form with field-level validation:

```dart
import 'package:flutter/material.dart';
import 'package:form_validator_x/form_validator_x.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) => FormValidatorX(value: value).validate(
              rules: [
                IsRequired(message: 'Email is required'),
                IsEmail(message: 'Enter a valid email address'),
              ],
            ),
          ),

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (value) => FormValidatorX(value: value).validate(
              rules: [
                IsRequired(message: 'Password is required'),
                MinLength(8, message: 'At least 8 characters'),
                MustContain('!', message: 'Must include !'),
              ],
            ),
          ),

          // Confirm Password
          TextFormField(
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            validator: (value) => FormValidatorX(value: value).validate(
              rules: [
                IsRequired(message: 'Please confirm your password'),
                IsEquals(
                  other: _passwordController.text,
                  message: 'Passwords do not match',
                ),
              ],
            ),
          ),

          // Age (numeric)
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Age'),
            validator: (value) => FormValidatorX(value: value).validate(
              rules: [
                IsRequired(message: 'Age is required'),
                IsNumeric(isInt: true, message: 'Enter a whole number'),
                IsNumBetween(18, 120, message: 'Age must be between 18 and 120'),
              ],
            ),
          ),

          // Birth date
          TextFormField(
            controller: _birthDateController,
            decoration: const InputDecoration(
              labelText: 'Birth Date (yyyy-MM-dd)',
            ),
            validator: (value) => FormValidatorX(value: value).validate(
              rules: [
                IsRequired(message: 'Birth date is required'),
                IsDate(message: 'Invalid date format'),
                IsDateBefore(
                  maxDate: DateTime.now(),
                  inclusive: true,
                  message: 'Birth date cannot be in the future',
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // All fields are valid
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
```

---

## Design Philosophy

- **Rules are independent.** Each rule is responsible for one check only. Combine them freely.
- **Silent on empty.** Most rules skip validation when the value is `null` or empty — use `IsRequired` explicitly when presence is mandatory. This avoids double-error scenarios.
- **Fail-fast.** Rules are evaluated in order; the first failure is returned immediately.
- **No runtime magic.** Rules are plain Dart objects — easy to test, easy to reason about.

---

## License

This project is licensed under the terms of the [LICENSE](./LICENSE) file.
