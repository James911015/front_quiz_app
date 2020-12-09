import 'package:app_quiz/services/user_model.dart';
import 'package:app_quiz/sqlite/DatabaseQuiz.dart';

class Singleton {
  static Singleton _instance;

  UserModel _userModel;

  static void initInstance() {
    if (_instance == null) {
      print("Singleton init");
      _instance = new Singleton();
    }
  }

  static Singleton getInstance() {
    return _instance;
  }

  UserModel get userModel => _userModel;

  set userModel(UserModel userModel) {
    _userModel = userModel;
  }
}
