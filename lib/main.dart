import 'package:app_quiz/pages/categories.dart';
import 'package:app_quiz/pages/list_players.dart';
import 'package:app_quiz/pages/login.dart';
import 'package:app_quiz/pages/quiz.dart';
import 'package:app_quiz/pages/user_register.dart';
import 'package:app_quiz/singleton.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Singleton.initInstance();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(),
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => Login(),
        "/user_register": (BuildContext context) => UserRegister(),
        "/categories": (BuildContext context) => Categories(),
        "/quiz": (BuildContext context) => Quiz(),
        "/list_champions": (BuildContext context) => ListPlayers(),
      },
    );
  }
}