import 'package:math_expressions/math_expressions.dart';

class Result {
  String newCalculate(String form) {
    String formula = form;
    Parser p = Parser();
    ContextModel cm = ContextModel();
    try {
      Expression exp = p.parse(formula);
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (e) {
      return '';
    }
  }
}
