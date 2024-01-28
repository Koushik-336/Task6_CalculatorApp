import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    Builder(builder: (BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Calculator',
        home: MyApp(),
      );
    }),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _equation = '0';
  String _result = '0';
  String _expression = '';
  double _equationFontSize = 38.0;
  double _resultFontSize = 48.0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _equation = '0';
        _result = '0';
        _equationFontSize = 38.0;
        _resultFontSize = 48.0;
      } else if (buttonText == '⌫') {
        _equationFontSize = 48.0;
        _resultFontSize = 38.0;
        _equation = _equation.substring(0, _equation.length - 1);
        if (_equation == '') {
          _equation = '0';
        }
      } else if (buttonText == '=') {
        _equationFontSize = 38.0;
        _resultFontSize = 48.0;

        _expression = _equation;
        _expression = _expression.replaceAll('×', '*');
        _expression = _expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);

          ContextModel cm = ContextModel();
          _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _equationFontSize = 30.0;
        _resultFontSize = 30.0;
        if (_equation == '0') {
          _equation = buttonText;
        } else {
          _equation = _equation + buttonText;
        }
      }
    });
  }

  Widget _buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: MaterialButton(
        onPressed: () => _buttonPressed(buttonText),
        padding: EdgeInsets.all(16.0),
        color: buttonColor,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _equation,
                        style: TextStyle(
                          fontSize: _equationFontSize,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.0),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _result,
                        style: TextStyle(
                          fontSize: _resultFontSize,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: <Widget>[
                    _buildButton('C', 1, Colors.grey[300]!),
                    _buildButton('⌫', 1, Colors.grey[300]!),
                    _buildButton('÷', 1, Colors.orange),
                    _buildButton('×', 1, Colors.orange),
                    _buildButton('7', 1, Colors.blue),
                    _buildButton('8', 1, Colors.blue),
                    _buildButton('9', 1, Colors.blue),
                    _buildButton('-', 1, Colors.orange),
                    _buildButton('4', 1, Colors.blue),
                    _buildButton('5', 1, Colors.blue),
                    _buildButton('6', 1, Colors.blue),
                    _buildButton('+', 1, Colors.orange),
                    _buildButton('1', 1, Colors.blue),
                    _buildButton('2', 1, Colors.blue),
                    _buildButton('3', 1, Colors.blue),
                    _buildButton('=', 2, Colors.green),
                    _buildButton('0', 1, Colors.blue),
                    _buildButton('.', 1, Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
