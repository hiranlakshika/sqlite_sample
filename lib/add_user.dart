import 'package:flutter/material.dart';
import 'package:sqlite_sample/db_helper.dart';
import 'package:sqlite_sample/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _id = TextEditingController();

  final TextEditingController _title = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _age = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saegis Dialog'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInputDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saegis Dialog'),
          content: TextFormField(
            onChanged: (value) {

            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
                  controller: _id,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
                  controller: _age,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextFormField(
                  controller: _address,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseHelper().insert(
                          DatabaseHelper.tableUser,
                          User(
                            id: _id.text,
                            title: _title.text,
                            name: _name.text,
                            age: double.parse(_age.text),
                            address: _address.text,
                          ));
                      Fluttertoast.showToast(
                          msg: "User has been added successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: const Text('Add User'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_id.text.isNotEmpty) {
                      await DatabaseHelper().delete(DatabaseHelper.tableUser, _id.text);
                      Fluttertoast.showToast(
                          msg: "User has been deleted successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: const Text('Delete User'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseHelper().update(DatabaseHelper.tableUser, User(
                        id: _id.text,
                        title: _title.text,
                        name: _name.text,
                        age: double.parse(_age.text),
                        address: _address.text,
                      ));
                      Fluttertoast.showToast(
                          msg: "User has been updated successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: const Text('Update User'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var value = await DatabaseHelper().selectByColumn(DatabaseHelper.tableUser, 'id', '3');
                    Fluttertoast.showToast(
                        msg: "User has been updated successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: const Text('Select'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
