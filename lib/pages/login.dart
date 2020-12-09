import 'package:app_quiz/pages/user_register.dart';
import 'package:app_quiz/services/user_service.dart';
import 'package:app_quiz/singleton.dart';
import 'package:app_quiz/sqlite/DatabaseQuiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:async';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DatabaseQuiz dataBase;
  TextEditingController ctrEmail;
  TextEditingController ctrPassword;
  UserService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "App Quiz",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 100,
                ),
                TextField(
                  controller: ctrEmail,
                  decoration: InputDecoration(
                      labelText: "Email", hintText: "Enter Email Here"),
                ),
                TextField(
                  controller: ctrPassword,
                  decoration: InputDecoration(
                      labelText: "Password", hintText: "Enter Password Here"),
                  obscureText: true,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Login"),
                  onPressed: () {
                    setState(() {
                      _login(context);
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Register"),
                  onPressed: () {
                    _showUserRegister(context);
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget principal(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 100,
              ),
              TextField(
                controller: ctrEmail,
                decoration: InputDecoration(
                    labelText: "Email", hintText: "Enter Email Here"),
              ),
              TextField(
                controller: ctrPassword,
                decoration: InputDecoration(
                    labelText: "Password", hintText: "Enter Password Here"),
                obscureText: true,
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Login"),
                onPressed: () {
                  setState(() {
                    _login(context);
                  });
                },
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Register"),
                onPressed: () {
                  _showUserRegister(context);
                },
              ),
            ],
          ),
        ));
  }

  void _login(BuildContext context) {
    if (ctrEmail.text.isEmpty) {
      Toast.show("Fill The Emal Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else if (ctrPassword.text.isEmpty) {
      Toast.show("Fill The Password Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      service.login(ctrEmail.text, ctrPassword.text).then((value) {
        if (value != null) {
          Singleton.getInstance().userModel = value;
          Navigator.of(context).pushNamed("/categories");
        } else {
          Navigator.of(context).pushNamed("/user_register");
        }
      });
    }
  }

  void _showUserRegister(BuildContext context) {
    Navigator.of(context).pushNamed("/user_register");
  }

  @override
  void initState() {
    super.initState();
    dataBase = DatabaseQuiz();
    ctrEmail = TextEditingController();
    ctrPassword = TextEditingController();
    service = new UserService();
  }

  @override
  void dispose() {
    super.dispose();
    ctrEmail.dispose();
    ctrPassword.dispose();
  }
}
