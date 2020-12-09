import 'package:app_quiz/pages/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {

  String selectCategory;
  int index=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
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
                        icon: new Image.asset('assests/ic_ingles.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "english";
                          index = 0;
                          _screemQuiz(context);
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: IconButton(
                        icon: new Image.asset('assests/ic_laboratorio.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "science";
                          index= 1;
                          _screemQuiz(context);
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
                        icon: new Image.asset('assests/ic_libro.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "spanish";
                          index= 2;
                          _screemQuiz(context);
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.purple,
                      child: IconButton(
                        icon: new Image.asset('assests/ic_logica.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "logic";
                          index= 3;
                          _screemQuiz(context);
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
                        icon: new Image.asset('assests/ic_matematicas.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "math";
                          index= 4;
                          _screemQuiz(context);
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                      child: IconButton(
                        icon: new Image.asset('assests/ic_religion.png',color: Colors.white,),
                        iconSize: 80,
                        onPressed: () {
                          selectCategory = "religion";
                          index= 5;
                          _screemQuiz(context);
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
    QuizArguments args= new QuizArguments(index: index,category: selectCategory);
    Navigator.pushNamed(context,"/quiz",arguments:args);
  }
}
