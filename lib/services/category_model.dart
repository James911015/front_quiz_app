import 'package:app_quiz/services/question_model.dart';

class CategoryModel {
  int category_id;
  String description;
  List<QuestionModel> questions;

  CategoryModel({this.category_id, this.description});

  factory CategoryModel.fromJson(List json) {

  }
}
