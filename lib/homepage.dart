import 'package:flutter/material.dart';
import 'login.dart';
import 'bmi.dart'; // Import your BMI page
import 'calculator.dart';
import 'parse.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ARIBWokwow'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your other content goes here

            SizedBox(height: 20), // Add some spacing
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
              title: Text('BMI Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BMICalculator()),
                );
              },
            ),
            Spacer(),
            ListTile(
              title: Text('Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorApp()),
                );
              },
            ),
            Spacer(), // Add some space to push the logout button to the bottom
            ListTile(
              title: Text('Parse Data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataPage()),
                );
              },
            ),
            Spacer(), // Add some space to push the logout button to the bottom
            ListTile(
              title: Text('Logout'),
              onTap: () {
                _performLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logic untuk proses logout
                _performLogout(context);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // Logic untuk proses logout, seperti menghapus token atau informasi login
    // Setelah logout, pindah ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
