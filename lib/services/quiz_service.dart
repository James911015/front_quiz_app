import 'dart:convert';

import 'package:app_quiz/services/aswer_model.dart';
import 'package:app_quiz/services/category_model.dart';
import 'package:app_quiz/services/question_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class QuizService {
  Future<List<QuestionModel>> findQuestionByCategoryId(int category_id) async {
    List<QuestionModel> questions = [];
    List<AnswerModel> aswers = [];
    var url = 'https://api-quiz-uniajc.herokuapp.com/questionws/' +
        category_id.toString();
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      final data = json.decode(response.body);
      for (Map i in data) {
        questions.add(QuestionModel.fromJson(i));
      }
      for (QuestionModel model in questions) {
        var url = 'https://api-quiz-uniajc.herokuapp.com/answerws/' +
            model.id.toString();
        var response2 = await http.get(url);
        if (response2.statusCode == 200 || response2.statusCode == 400) {
          final data2 = json.decode(response2.body);
          for (Map i in data2) {
            aswers.add(AnswerModel.fromJson(i));
          }
        }
      }
      return questions;
    } else {
      return null;
    }
  }
}
