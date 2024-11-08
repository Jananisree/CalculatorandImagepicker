import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

import 'CalculatorWidget.dart';

class GetxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                )),
          ),
        ),
        body: GetX<CalculatorController>(
          init: CalculatorController(),
          builder: (controller) {
            return CalculatorWidget(
              expression: controller.expression.value,
              result: controller.result.value,
              onButtonPressed: (value) => controller.appendExpression(value),
              onCalculatePressed: controller.calculateResult,
              onClearPressed: controller.clearExpression,
            );
          },
        ),
      ),
    );
  }
}

// Calculator Controller for GetX State Management
class CalculatorController extends GetxController {
  var expression = ''.obs;
  var result = '0'.obs;

  // Append expression
  void appendExpression(String value) {
    if (value == '%') {
      _handlePercentage();
    } else {
      expression.value += value;
    }
  }

  // Handle percentage calculation
  void _handlePercentage() {
    try {
      if (expression.isNotEmpty) {
        Parser parser = Parser();
        Expression exp = parser.parse(expression.value.replaceAll('÷', '/').replaceAll('x', '*'));
        ContextModel contextModel = ContextModel();
        double evaluatedResult = exp.evaluate(EvaluationType.REAL, contextModel);

        // Divide by 100 for percentage
        expression.value = (evaluatedResult / 100).toString();
        result.value = expression.value;
      }
    } catch (e) {
      result.value = 'Error';
    }
  }

  // Calculate result
  void calculateResult() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression.value.replaceAll('÷', '/').replaceAll('x', '*'));
      ContextModel contextModel = ContextModel();
      result.value = exp.evaluate(EvaluationType.REAL, contextModel).toString();
    } catch (e) {
      result.value = 'Error';
    }
  }

  // Clear expression
  void clearExpression() {
    expression.value = '';
    result.value = '0';
  }
}
