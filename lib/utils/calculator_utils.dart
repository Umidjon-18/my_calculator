import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalculatorUtils {
  var icMoonPath = 'assets/images/ic_moon.png';
  var icSunPath = 'assets/images/ic_sun.png';
  var icSelectedPath = 'assets/images/ic_selected.png';
  var first = 'assets/images/ic_selected.png';
  var second = 'assets/images/ic_moon.png';
  Color pageBackground = const Color(0xff1E1E1E);
  Color defaultButtonColor = const Color(0xff2E2F38);
  Color defaultButtonTextColor = Colors.white;
  Color defaultInputTextColor = Colors.white;
  Color defaultThemeBgColor = const Color(0xff2E2F38);
  Color defaultTopButtonColor = const Color(0xff4E505F);
  final calculateController = TextEditingController();
  final resultController = TextEditingController();
  double topFieldSize = 35;
  double bottomFieldSize = 45;
  int theme = 1;
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    'del',
    '=',
  ];
  final List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  final List<String> operators = ['/', '+', '-', '%', '=', '*', 'del'];
  var lastOperator = '';
  var lastOperated = '';
  bool isSimple = true;

  var scientificButtons = {
    'assets/images/main_images/sc_rad.png': '',
    'assets/images/main_images/sc_sin.png': 'SINR(',
    'assets/images/main_images/sc_cos.png': 'COSR(',
    'assets/images/main_images/sc_tan.png': 'TANR(',
    'assets/images/main_images/sc_pi.png': 'PI',
    'assets/images/main_images/sc_sinh.png': 'ASINR(',
    'assets/images/main_images/sc_cosh.png': 'ACOSR(',
    'assets/images/main_images/sc_tanh.png': 'ATGR(',
    'assets/images/main_images/sc_x_1.png': '^(-1)',
    'assets/images/main_images/sc_x_2.png': '^2',
    'assets/images/main_images/sc_x_3.png': '^3',
    'assets/images/main_images/sc_exp.png': 'e',
    'assets/images/main_images/sc_log.png': 'LOG10(',
    'assets/images/main_images/sc_ln.png': 'LOG(',
    'assets/images/main_images/sc_e.png': 'e',
    'assets/images/main_images/sc_e_n.png': 'e^',
    'assets/images/main_images/sc_x_module.png': 'ABS(',
    'assets/images/main_images/sc_sqrt.png': 'SQRT(',
    'assets/images/main_images/sc_sqrt_3.png': '^(-3)',
    'assets/images/main_images/sc_n_fac.png': 'FACT(',
  };

  List<Tab> myTabs = [
    const Tab(
      icon: Icon(
        Icons.calculate_outlined,
        size: 28,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.currency_exchange_sharp,
        size: 28,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.line_style,
        size: 28,
      ),
    ),
  ];

  Map<String, String> simpleButtons = {
    'assets/images/main_images/x_n.png': '^',
    'assets/images/main_images/foiz.png': '%',
    'assets/images/main_images/bolish.png': '/',
    'assets/images/main_images/backspace.png': 'del',
    'assets/images/main_images/seven.png': '7',
    'assets/images/main_images/eight.png': '8',
    'assets/images/main_images/nine.png': '9',
    'assets/images/main_images/multiplication.png': '*',
    'assets/images/main_images/four.png': '4',
    'assets/images/main_images/five.png': '5',
    'assets/images/main_images/six.png': '6',
    'assets/images/main_images/subtraction.png': '-',
    'assets/images/main_images/one.png': '1',
    'assets/images/main_images/two.png': '2',
    'assets/images/main_images/three.png': '3',
    'assets/images/main_images/addition.png': '+',
    'assets/images/main_images/vergul.png': '.',
    'assets/images/main_images/zero.png': '0',
    'assets/images/main_images/brackets.png': '(',
    'assets/images/main_images/equal.png': '=',
  };


  String splitter(String string) {
    final List<String> operators = ['/', '+', '-', '*'];
    var result = string;
    for (var element in operators) {
      result = result.split(element).last;
    }
    return result;
  }

  bool isOperator(String item) {
    var operatorList = ['/', '+', '-', '*', '.'];
    for (var element in operatorList) {
      if (item == element) {
        return true;
      }
    }
    return false;
  }

  calculate(String operation) {
    if (operation.contains('+') ||
        operation.contains('-') ||
        operation.contains('*') ||
        operation.contains('/') ||
        operation.contains('%') ||
        operation.contains('(') ||
        operation.contains(')')) {
      if (!operators.contains(operation.split('').last)) {
        var result = Expression(operation).eval();
        return result.toString().contains('.')
            ? result!.toStringAsFixed(3)
            : result.toString();
      }
      var result =
          Expression(operation.substring(0, operation.length - 1)).eval();
      return result.toString().contains('.')
          ? result!.toStringAsFixed(3)
          : result.toString();
    }
    return operation;
  }
}
