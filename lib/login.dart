import 'package:flutter/material.dart';
import 'register.dart';
import 'homepage.dart'; // Pastikan mengganti sesuai dengan nama file yang benar

class LoginPage extends StatelessWidget {
  // Hardcoded username dan password (contoh saja, seharusnya disimpan secara aman)
  final String hardcodedUsername = 'user123';
  final String hardcodedPassword = 'password123';

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover,
                        width: 200, // Sesuaikan lebar gambar sesuai kebutuhan
                        height: 200, // Sesuaikan tinggi gambar sesuai kebutuhan
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Logic untuk proses login
                            String enteredUsername = usernameController.text;
                            String enteredPassword = passwordController.text;

                            if (enteredUsername == hardcodedUsername &&
                                enteredPassword == hardcodedPassword) {
                              // Tampilkan popup berhasil jika login berhasil
                              _showSuccessDialog(context);
                            } else {
                              // Tampilkan popup dengan saran untuk register jika login gagal
                              _showErrorDialog(context);
                            }
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.blue, // Ganti warna sesuai keinginan
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Pindah ke halaman register
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text('Go to Register'),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.green, // Ganti warna sesuai keinginan
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('You have successfully logged in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pushReplacement(
                  // Ganti halaman dan hapus halaman login dari stack
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password. Please register.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
