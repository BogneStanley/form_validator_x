import 'package:form_validator_x/rules/rule_contract.dart';

class FormValidatorX {

  final String? value;

  FormValidatorX({required this.value});

  String? validate({List<RuleContract> rules = const []}) {
    for (var rule in rules) {
      final result = rule.validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
