import 'package:http/http.dart';

class CategoriesModel {
  String category;
  List<QuestionsAndAnswerModel> listQuestionAndAnswers;

  CategoriesModel({this.category, this.listQuestionAndAnswers});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    var list= json["questionAndAnswers"] as List;
    //print(list.runtimeType);
    List<QuestionsAndAnswerModel> questionsAndAnswerModel= list.map((e) => QuestionsAndAnswerModel.fromJson(e)).toList();
    return CategoriesModel(
      category: json['category'],
      listQuestionAndAnswers: questionsAndAnswerModel,
    );
  }
}

class QuestionsAndAnswerModel {
  String question;
  List<Answers> listAnswer;

  QuestionsAndAnswerModel({this.question, this.listAnswer});

  factory QuestionsAndAnswerModel.fromJson(Map<String,dynamic> json) {
    var list= json["answers"] as List;
    //print(list.runtimeType);
    List<Answers> answerList= list.map((e) => Answers.fromJson(e)).toList();
    return QuestionsAndAnswerModel(
      question: json["question"],
      listAnswer: answerList,
    );
  }
}

class Answers {
  String answer;
  bool response;

  Answers({this.answer, this.response});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      answer: json['answer'],
      response: json['response'],
    );
  }
}

