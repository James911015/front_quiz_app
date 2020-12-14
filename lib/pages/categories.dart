import 'package:app_quiz/pages/quiz.dart';
import 'package:app_quiz/services/questions.dart';
import 'package:app_quiz/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  String selectCategory;
  int index = 0;
  UserService service;
  CategoriesModel categories;

  Categories() {
    service = new UserService();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            }),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_ingles.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "english";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_laboratorio.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "science";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_libro.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "history";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.purple,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_logica.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "logic";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.orange,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_matematicas.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "math";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                      child: IconButton(
                        icon: new Image.asset(
                          'assests/ic_religion.png',
                          color: Colors.white,
                        ),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "religion";
                          service.question(selectCategory).then((value) {
                            if (value != null) {
                              categories = value;
                              index = 0;
                              _screemQuiz(context);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _screemQuiz(BuildContext context) {
    QuizArguments args = new QuizArguments(index: index, category: selectCategory,categories: categories);
    Navigator.pushNamed(context, "/quiz", arguments: args);
  }
}
