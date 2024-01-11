import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'homepage.dart'; // Import your HomePage
import 'login.dart'; // Import your LoginPage
import 'bmi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _inputValue = '0';

  void _onDigitPressed(String digit) {
    setState(() {
      if (_inputValue == '0') {
        _inputValue = digit;
      } else {
        _inputValue += digit;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _inputValue = '0';
    });
  }

  void _onEqualsPressed() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_inputValue);
        ContextModel cm = ContextModel();
        _inputValue = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        _inputValue = 'Error';
      }
    });

    // Show the result in a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(_inputValue),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(String text, {Color textColor = Colors.black}) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'C') {
          _onClearPressed();
        } else if (text == '=') {
          _onEqualsPressed();
        } else {
          _onDigitPressed(text);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
        onPrimary: textColor,
        padding: EdgeInsets.all(20.0),
        textStyle: TextStyle(fontSize: 20.0),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  _inputValue,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton('0'),
                    _buildButton('00'),
                    _buildButton('.'),
                    _buildButton('+'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildButton('C', textColor: Colors.red),
                    _buildButton('='),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
      // Add the drawer here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('BMI Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BMICalculator()),
                );
              },
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
