import 'package:app_quiz/services/user_model.dart';
import 'package:app_quiz/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import '../singleton.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserUserRegisterState createState() => _UserUserRegisterState();
}

class _UserUserRegisterState extends State<UserRegister> {
  TextEditingController ctrName;
  TextEditingController ctrAge;
  TextEditingController ctrEmail;
  TextEditingController ctrPassword;
  UserService service = new UserService();

  bool validateName = false;
  bool validateAge = false;
  bool validateEmail = false;
  bool validatePassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("User Register")),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Register User"),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  //errorText: validateName ? "Value Cant Be Empty" : null
                ),
                controller: ctrName,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                controller: ctrAge,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                controller: ctrEmail,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                controller: ctrPassword,
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Register"),
                onPressed: () {
                  setState(() {
                    _saveUser(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveUser(BuildContext context) {
    if (ctrName.text.isEmpty) {
      Toast.show("Fill The Name Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else if (ctrAge.text.isEmpty) {
      Toast.show("Fill The Age Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else if (ctrEmail.text.isEmpty) {
      Toast.show("Fill The Emal Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else if (ctrPassword.text.isEmpty) {
      Toast.show("Fill The Password Field", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      UserModel userModel = new UserModel();
      userModel.name = ctrName.text;
      userModel.age = int.parse(ctrAge.text);
      userModel.email = ctrEmail.text;
      userModel.password = ctrPassword.text;
      print('Register:' + userModel.toJson().toString());
      service.register(userModel).then((value) {
        if (value != null) {
          service.login(ctrEmail.text, ctrPassword.text).then((value) {
            if (value != null) {
              Singleton.getInstance().userModel = value;
              Navigator.of(context).pushNamed("/categories");
            } else {
              Navigator.of(context).pushNamed("/user_register");
            }
          });
          //Navigator.of(context).pushNamed("/categories");
        } else {
          Toast.show("Register Fail!!!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          Navigator.of(context).pushNamed("/");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ctrName = TextEditingController();
    ctrAge = TextEditingController();
    ctrEmail = TextEditingController();
    ctrPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    ctrName.dispose();
    ctrAge.dispose();
    ctrEmail.dispose();
    ctrPassword.dispose();
  }
}
