import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = '';
  String result = '0';

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(color: Colors.white),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: buttonList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (BuildContext context, int index) {
                return createCutomButton(buttonList[index]);
              },
            ),
          )),
        ],
      ),
    );
  }

  Widget createCutomButton(String btnText) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          handleButtons(btnText);
        });
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: createForeColor(btnText),
          backgroundColor: createBackColor(btnText),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Text(
        btnText,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }

  void handleButtons(String btnText) {
    if (btnText == 'AC') {
      userInput = '';
      result = '0';
      return;
    }

    if (btnText == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return;
      }
    }

    if (btnText == '=') {
      result = calculator();
      userInput = result;
      if (userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');

        if (result.endsWith('.0')) {
          result = result.replaceAll('.0', '');
        }
      }

      userInput = '';
      return;
    }

    userInput = userInput + btnText;
  }

  String calculator() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());

      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }

  createBackColor(String btnText) {
    if (btnText == '=' ||
        btnText == '+' ||
        btnText == '*' ||
        btnText == '/' ||
        btnText == '-') {
      return Colors.orange;
    } else if (btnText == 'AC' ||
        btnText == '(' ||
        btnText == ')' ||
        btnText == 'C') {
      return Colors.blueGrey;
    } else {
      return Colors.white;
    }
  }

  createForeColor(String btnText) {
    if (btnText == '=' ||
        btnText == '+' ||
        btnText == '*' ||
        btnText == '/' ||
        btnText == '-') {
      return Colors.white;
    } else if (btnText == 'AC' ||
        btnText == '(' ||
        btnText == ')' ||
        btnText == 'C') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
