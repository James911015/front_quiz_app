class AnswerModel {
  int id;
  String description;
  int question_id;
  bool response;

  AnswerModel({this.id, this.description, this.question_id, this.response});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      question_id: json['question_id'] ?? '',
      response: json['response'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AnswerModel{id: $id, description: $description, question_id: $question_id, response: $response}';
  }
}
