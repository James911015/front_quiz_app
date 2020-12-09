import 'package:app_quiz/services/aswer_model.dart';

class QuestionModel {
  int id;
  String description;
  int category_id;
  List<AnswerModel> aswers;

  QuestionModel({this.id, this.description, this.category_id});


  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      category_id: json['category_id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'QuestionModel{id: $id, description: $description, category_id: $category_id}';
  }
}
