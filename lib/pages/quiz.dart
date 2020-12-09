import 'dart:async';

import 'package:app_quiz/services/quiz_service.dart';
import 'package:app_quiz/sqlite/DatabaseQuiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../singleton.dart';

class Quiz extends StatefulWidget {
  @override
  _Quizstate createState() => _Quizstate();
}

class QuizArguments {
  int index;
  String category;

  QuizArguments({this.index, this.category});
}

class _Quizstate extends State<Quiz> {
  DatabaseQuiz database;
  Timer timer;
  int start = 60;
  int countQuestions = 0;
  int categoryId;
  QuizService service;
  int score = 0;
  var answers = [];
  QuizArguments args;

  var categories = [
    {
      "english": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    },
    {
      "science": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    },
    {
      "spanish": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    },
    {
      "logic": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    },
    {
      "math": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    },
    {
      "religion": [
        {
          "question": "Question 1",
          "answers": [
            {"answer": "Answer 1-1", "response": true},
            {"answer": "Answer 1-2", "response": false},
            {"answer": "Answer 1-3", "response": false},
            {"answer": "Answer 1-4", "response": false},
          ]
        },
        {
          "question": "Question 2",
          "answers": [
            {"answer": "Answer 2-1", "response": false},
            {"answer": "Answer 2-2", "response": true},
            {"answer": "Answer 2-3", "response": false},
            {"answer": "Answer 2-4", "response": false},
          ]
        },
        {
          "question": "Question 3",
          "answers": [
            {"answer": "Answer 3-1", "response": false},
            {"answer": "Answer 3-2", "response": false},
            {"answer": "Answer 3-3", "response": true},
            {"answer": "Answer 3-4", "response": false},
          ]
        },
        {
          "question": "Question 4",
          "answers": [
            {"answer": "Answer 4-1", "response": false},
            {"answer": "Answer 4-2", "response": false},
            {"answer": "Answer 4-3", "response": false},
            {"answer": "Answer 4-4", "response": true},
          ]
        },
        {
          "question": "Question 5",
          "answers": [
            {"answer": "Answer 5-1", "response": true},
            {"answer": "Answer 5-2", "response": false},
            {"answer": "Answer 5-3", "response": false},
            {"answer": "Answer 5-4", "response": false},
          ]
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    args = ModalRoute.of(context).settings.arguments;

    if (countQuestions < 5) {
      answers =
          (categories[args.index][args.category][countQuestions]["answers"]);
    }

    return MaterialApp(
        title: "Quiz!!!",
        theme: themeData(),
        home: countQuestions < categories[args.index][args.category].length
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
    } else if (args.category.toLowerCase() == "spanish") {
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
                            categories[args.index][args.category]
                                [countQuestions]["question"],
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
                          answers[0]["answer"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if (answers[0]["response"] == true) {
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
                          answers[1]["answer"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            if (answers[1]["response"] == true) {
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
                          answers[2]["answer"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            if (answers[2]["response"] == true) {
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
                          answers[3]["answer"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        color: Colors.orange,
                        onPressed: () {
                          setState(() {
                            if (answers[3]["response"] == true) {
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
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
