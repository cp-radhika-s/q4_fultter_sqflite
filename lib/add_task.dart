import 'package:flutter/material.dart';
import 'package:q4_todo_flutter/user.dart';

import 'db_helper.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  late DbHelper helper;

  @override
  void initState() {
    setState(() {
      this.helper = DbHelper();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Add Task',
              ),
            ),
            body: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Enter name'),
                      controller: nameController,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Enter age'),
                      controller: ageController,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter email'),
                      controller: emailController,
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                        onPressed: () {
                          User user = User(
                              nameController.text,
                              emailController.text,
                              int.parse(ageController.text));
                          helper.insertUser(user);
                          Navigator.pop(context);
                        },
                        child: Text("Add Employee"))
                  ],
                ))));
  }
}
