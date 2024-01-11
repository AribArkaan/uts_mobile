import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package
import 'homepage.dart'; // Import your HomePage
import 'login.dart'; // Import your LoginPage
import 'calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  bool showBMIResult =
      false; // New variable to control the visibility of the result and chart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16),
            if (showBMIResult) ...[
              Text(
                'BMI Result: $bmiResult',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 1),
                    ),
                    minX: 0,
                    maxX: 100,
                    minY: 0,
                    maxY: 50,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 10),
                          FlSpot(50, 30),
                          FlSpot(100, 20),
                        ],
                        isCurved: true,
                        colors: [Colors.blue],
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
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
              title: Text('Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorApp()),
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

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double bmi = weight / (height * height) * 10000; // BMI formula
      setState(() {
        bmiResult = bmi;
        showBMIResult = true; // Set to true to show the result and chart
      });
    } else {
      setState(() {
        bmiResult = 0.0;
        showBMIResult = false; // Set to false to hide the result and chart
      });
    }
  }
}
