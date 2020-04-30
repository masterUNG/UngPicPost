import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ungpicpost/model/user_model.dart';
import 'package:ungpicpost/utility/normal_dialog.dart';
import 'package:ungpicpost/widget/register.dart';
import 'package:ungpicpost/widget/show_list_post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Field
  String user, password;

  // Method
  Widget mySizebox() {
    return SizedBox(
      width: 5.0,
      height: 20.0,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      onPressed: () {
        if (user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'มีช่องว่าง', 'กรุณากรอก ทุกช่อง คะ');
        } else {
          checkAuthen();
        }
      },
      child: Text('Sign In'),
    );
  }

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/mai/getUserWhereUserMaster.php?isAdd=true&User=$user';
    Response response = await Dio().get(url);
    print('res ==> $response');
    if (response.toString() == 'null') {
      normalDialog(context, 'User False', 'No $user in my Database');
    } else {
      var result = json.decode(response.data);
      print('result ==>> $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromJSON(map);

        if (password == userModel.password) {
          print('Welcom ${userModel.name}');

          MaterialPageRoute route = MaterialPageRoute(builder: (value)=>ShowListPost());
          Navigator.pushAndRemoveUntil(context, route, (value)=>false);

        } else {
          normalDialog(context, 'Password False', 'Please Try Again Password False');
        }

      }
    }
  }

  Widget signUpButton() {
    return OutlineButton(
      onPressed: () {
        print('You Click SignUp');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (value) {
          return Register();
        });
        Navigator.of(context).push(materialPageRoute);
      },
      child: Text('Sign Up'),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        mySizebox(),
        signUpButton(),
      ],
    );
  }

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(labelText: 'User :'),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password :'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Pic Post',
      style: GoogleFonts.shadowsIntoLight(
          textStyle: TextStyle(
        fontSize: 30.5,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.green.shade900,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Colors.lime],
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                userForm(),
                passwordForm(),
                mySizebox(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
