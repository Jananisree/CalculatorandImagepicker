import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';

import 'CalculatorWidget.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';

  String get expression => _expression;
  String get result => _result;

  // Append expression
  void appendExpression(String value) {
    if (value == '%') {
      _handlePercentage();
    } else {
      _expression += value;
    }
    notifyListeners();
  }

  // Handle percentage calculation
  void _handlePercentage() {
    try {
      if (_expression.isNotEmpty) {
        Parser parser = Parser();
        Expression exp = parser.parse(_expression.replaceAll('÷', '/').replaceAll('x', '*'));
        ContextModel contextModel = ContextModel();
        double evaluatedResult = exp.evaluate(EvaluationType.REAL, contextModel);

        // Divide by 100 for percentage
        _expression = (evaluatedResult / 100).toString();
        _result = _expression;
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  // Calculate result
  void calculateResult() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(_expression.replaceAll('÷', '/').replaceAll('x', '*'));
      ContextModel contextModel = ContextModel();
      _result = exp.evaluate(EvaluationType.REAL, contextModel).toString();
    } catch (e) {
      _result = 'Error';
    }
    notifyListeners();
  }

  // Clear expression
  void clearExpression() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }
}

class Providercalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // Set the height you want
            child: AppBar(
              backgroundColor: Color(0xffF5F5F5), // AppBar background color
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 10, left: 35), // Adjust padding as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/logoo.png"),
                        SizedBox(width: 10),
                        Text(
                          "RadicalStart",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              return CalculatorWidget(
                expression: provider.expression,
                result: provider.result,
                onButtonPressed: (value) => provider.appendExpression(value),
                onCalculatePressed: provider.calculateResult,
                onClearPressed: provider.clearExpression,
              );
            },
          ),
        ),
      ),
    );
  }
}
