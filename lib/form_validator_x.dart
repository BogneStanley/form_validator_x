import 'package:form_validator_x/rules/rule_contract.dart';
export 'rules/rule_contract.dart';
export 'rules/common_rules/common_rules.dart';
export 'rules/date_rules/date_rules.dart';
export 'rules/numeric_rules/numeric_rules.dart';

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
