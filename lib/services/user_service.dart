import 'dart:convert';
import 'package:app_quiz/services/questions.dart';
import 'package:app_quiz/services/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel> login(String email, String password) async {
    var url = 'https://api-quiz-uniajc.herokuapp.com/userws/login/' +
        email +
        '/' +
        password;

    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UserModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
  
  

  Future<UserModel> register(UserModel userModel) async {
    var url2 = 'https://api-quiz-uniajc.herokuapp.com/userws/create';
    final response2 = await http.post(url2,
        headers: {'Content-type': 'application/json'},
        body: json.encode(userModel.toJson()));
    if (response2.statusCode == 200 || response2.statusCode == 400) {
      return UserModel.fromJson(
        json.decode(response2.body),
      );
    } else {
      return null;
    }
  }


  Future<CategoriesModel> question(String category) async {
    var url = 'https://api-quiz-uniajc.herokuapp.com/questionws/questions/'+category;
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print('JsoQuestion:'+response.body);
      return CategoriesModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
  
}
