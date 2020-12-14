import 'dart:async';

import 'package:app_quiz/services/questions.dart';
import 'package:app_quiz/services/quiz_service.dart';
import 'package:app_quiz/services/user_service.dart';
import 'package:app_quiz/sqlite/DatabaseQuiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../singleton.dart';

class Quiz extends StatefulWidget {
  @override
  _Quizstate createState() => _Quizstate();
}

class QuizArguments {
  int index;
  String category;
  CategoriesModel categories;


  QuizArguments({this.index, this.category,this.categories});
}

class _Quizstate extends State<Quiz> {
  DatabaseQuiz database;
  Timer timer;
  int start = 60;
  int countQuestions = 0;
  int categoryId;
  QuizService service;
  UserService userService;
  int score = 0;
  List<Answers> answers = [];
  QuizArguments args;
  CategoriesModel categories;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //categories[args.index][args.category][countQuestions]["question"]

    args = ModalRoute.of(context).settings.arguments;
    //print('Categories2'+categories[args.index]);
    categories= args.categories;
    /*print("Pregunta:"+categories.listQuestionAndAnswers.elementAt(countQuestions).question);
    print("Respuesta:"+categories.listQuestionAndAnswers.elementAt(countQuestions).listAnswer.elementAt(0).answer);
    print("Buena:"+categories.listQuestionAndAnswers.elementAt(countQuestions).listAnswer.elementAt(0).response.toString());*/
    print("length:"+categories.listQuestionAndAnswers.length.toString());


    if (countQuestions < categories.listQuestionAndAnswers.length) {
      answers = categories.listQuestionAndAnswers.elementAt(countQuestions).listAnswer;
    }

    return MaterialApp(
        title: "Quiz!!!",
        theme: themeData(),
        home: countQuestions < categories.listQuestionAndAnswers.length
            ? bodyQuiz(context)
            : bodyScore(context));
  }

  ThemeData themeData() {
    if (args.category.toLowerCase() == "english") {
      return ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else if (args.category.toLowerCase() == "science") {
      return ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else if (args.category.toLowerCase() == "history") {
      return ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else if (args.category.toLowerCase() == "logic") {
      return ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else if (args.category.toLowerCase() == "math") {
      return ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else {
      return ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    }
  }

  Widget bodyScore(BuildContext context) {
    Score scored = new Score();
    scored.name = Singleton.getInstance().userModel.name.toString();
    scored.category = args.category;
    scored.score = score;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "RESULT!!!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text("Score: " + score.toString(), style: TextStyle(fontSize: 40)),
        RaisedButton(
            child: Text("Save And Go Scores"),
            onPressed: () {
              database.saveScore(scored);
              Navigator.pushNamed(context, "/list_champions");
            })
      ])),
    );
  }

  Widget bodyQuiz(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Quiz!!!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("$start", style: TextStyle(fontSize: 40)),
              Container(
                  height: 200,
                  color: Colors.red,
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            categories.listQuestionAndAnswers.elementAt(countQuestions).question,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100,
                      child: RaisedButton(
                        child: Text(
                          answers.elementAt(0).answer,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if (answers.elementAt(0).response == true) {
                              Toast.show("CORRECT", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              score++;
                            }
                            start = 0;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: RaisedButton(
                        child: Text(
                            answers.elementAt(1).answer,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            if (answers.elementAt(1).response == true) {
                              Toast.show("CORRECT", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              score++;
                            }
                            start = 0;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.green,
                      child: RaisedButton(
                        child: Text(
                          answers.elementAt(2).answer,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            if (answers.elementAt(2).response == true) {
                              Toast.show("CORRECT", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              score++;
                            }
                            start = 0;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: RaisedButton(
                        child: Text(
                          answers.elementAt(3).answer,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.orange,
                        onPressed: () {
                          setState(() {
                            if (answers.elementAt(3).response == true) {
                              Toast.show("CORRECT", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              score++;
                            }
                            start = 0;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (start < 1) {
            timer.cancel();
            nextQuestion();
          } else {
            start = start - 1;
          }
        },
      ),
    );
  }

  void nextQuestion() {
    start = 60;
    countQuestions++;
    print("CountQuestions:" + countQuestions.toString());
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    service = new QuizService();
    service.findQuestionByCategoryId(1);
    database = new DatabaseQuiz();
    userService = new UserService();
    //categories= [userService.question()];

    //print('Categories2:'+categories.toString());
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
