import 'package:flutter/material.dart';
import 'homepage.dart';

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

class CRUD extends StatefulWidget {
  @override
  _CRUDState createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  List<User> users = [
    User(id: 1, name: 'John Doe', email: 'john@example.com'),
    User(id: 2, name: 'Jane Doe', email: 'jane@example.com'),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  User? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple CRUD'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Actions')),
              ],
              rows: users.map((user) {
                return DataRow(
                  cells: [
                    DataCell(Text('${user.id}')),
                    DataCell(Text(user.name)),
                    DataCell(Text(user.email)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editUser(user);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteUser(user);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add or Update User:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _addUser();
                        },
                        child: Text('Add'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _updateUser();
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addUser() {
    int newId = users.isNotEmpty ? users.last.id + 1 : 1;
    users.add(
      User(
        id: newId,
        name: nameController.text,
        email: emailController.text,
      ),
    );
    _clearForm();
  }

  void _editUser(User user) {
    setState(() {
      selectedUser = user;
      nameController.text = user.name;
      emailController.text = user.email;
    });
  }

  void _updateUser() {
    if (selectedUser != null) {
      selectedUser!.name = nameController.text;
      selectedUser!.email = emailController.text;
      _clearForm();
    }
  }

  void _deleteUser(User user) {
    setState(() {
      users.remove(user);
      _clearForm();
    });
  }

  void _clearForm() {
    setState(() {
      selectedUser = null;
      nameController.clear();
      emailController.clear();
    });
  }
}
