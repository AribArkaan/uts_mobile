import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MANUAL CRUD',
      home: CRUD(),
    );
  }
}

class User {
  int id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});
}

class UserDatabase {
  List<User> users = [];

  // Create
  void addUser(User user) {
    users.add(user);
  }

  // Read
  List<User> getUsers() {
    return users;
  }

  // Delete
  void deleteUser(int userId) {
    users.removeWhere((user) => user.id == userId);
  }
}

class CRUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase();

    // Create
    userDatabase
        .addUser(User(id: 1, name: 'John Doe', email: 'john@example.com'));
    userDatabase
        .addUser(User(id: 2, name: 'Jane Doe', email: 'jane@example.com'));

    // Read
    List<User> allUsers = userDatabase.getUsers();
    print('All Users:');
    allUsers.forEach((user) {
      print('ID: ${user.id}, Name: ${user.name}, Email: ${user.email}');
    });

    // Update

    // Delete
    userDatabase.deleteUser(2);
    print('\nAfter Delete:');
    userDatabase.getUsers().forEach((user) {
      print('ID: ${user.id}, Name: ${user.name}, Email: ${user.email}');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: Center(
        child: Text('Check the console for CRUD operation results.'),
      ),
    );
  }
}
