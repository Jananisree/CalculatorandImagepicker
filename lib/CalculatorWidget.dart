import 'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget {
  final String expression;
  final String result;
  final Function(String) onButtonPressed;
  final Function() onCalculatePressed;
  final Function() onClearPressed;

  CalculatorWidget({
    required this.expression,
    required this.result,
    required this.onButtonPressed,
    required this.onCalculatePressed,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Define button labels
    final List<String> buttons = [
      'C', '%', '⌫', '÷',
      '7', '8', '9', 'x',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '.', '0', '00', '=',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate childAspectRatio based on the screen width
          double aspectRatio = constraints.maxWidth < 600 ? 1.2 : 1.5;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth < 600 ? 4 : 5,
                    childAspectRatio: aspectRatio,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    String label = buttons[index];

                    // Define button colors
                    Color buttonColor = Colors.white;
                    Color textColor = Colors.black;

                    if (label == '=') {
                      buttonColor = Colors.blue.shade800;
                      textColor = Colors.white;
                    } else if (['÷', 'x', '-', '+'].contains(label)) {
                      buttonColor = Colors.orange;
                      textColor = Colors.white;
                    } else if (['C', '%', '⌫'].contains(label)) {
                      buttonColor = Color(0xffF5F5F5); // First row custom color
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (label == 'C') {
                          onClearPressed();
                        } else if (label == '=') {
                          onCalculatePressed();
                        } else {
                          onButtonPressed(label);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: buttonColor,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 24,
                          color: textColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        result,
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        expression,
                        style: TextStyle(fontSize: 28, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
