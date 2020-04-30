import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungpicpost/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  String name, user, password;

  // Method

  Widget nameForm() {
    IconData iconData = Icons.account_box;
    String hind = 'Name :';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => name = value.trim(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(iconData),
              hintText: hind,
            ),
          ),
        ),
      ],
    );
  }

  Widget userForm() {
    IconData iconData = Icons.email;
    String hind = 'User :';

    return Container(
      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(iconData),
                hintText: hind,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordForm() {
    IconData iconData = Icons.lock;
    String hind = 'Password :';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => password = value.trim(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(iconData),
              hintText: hind,
            ),
          ),
        ),
      ],
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('name = $name, user = $user, password = $password');
        if (name == null ||
            name.isEmpty ||
            user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Fill Every Blank');
        } else {
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    String url = 'https://www.androidthai.in.th/mai/addUserUng.php?isAdd=true&Name=$name&User=$user&Password=$password';
        
    Response response = await Dio().get(url);
    print('response = $response');

    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normalDialog(context, 'Register False', 'Please Try Again');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        title: Text('Register'),
        backgroundColor: Colors.lime,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 50.0),
        children: <Widget>[
          nameForm(),
          userForm(),
          passwordForm(),
        ],
      ),
    );
  }
}
