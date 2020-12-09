import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseQuiz {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    print('Data Initttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
    return _db;
  }

  initDB() async {
    return await openDatabase("database.db", version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE USER (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, email TEXT, password TEXT);");
      db.execute(
          "CREATE TABLE SCORE (score_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT,score INTEGER);");
    });
  }

  Future<User> save(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert("USER", user.toMap());
    return user;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("USER");
    List<User> users = [];
    if (maps.length > 0) {
      for (int x = 0; x < maps.length; x++) {
        users.add(User.fromMap(maps[x]));
      }
    }
    return users;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete("USER", where: "id=?", whereArgs: [id]);
  }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient
        .update("USER", user.toMap(), where: "id=?", whereArgs: [user.id]);
  }

  Future<User> getUser(String email, String password) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("USER",
        where: "email = ? and password = ?", whereArgs: [email, password]);
    User user;
    if (maps.length > 0) {
      print('getUser');
      return user = User.fromMap(maps[0]);
      print('nameeee' + maps.toString());
    }
    print('Not getUser');
    return null;
  }

  //----------------------------------------------------------------------------

  Future<int> saveScore(Score score) async {
    var dbClient = await db;
    return score.score_id = await dbClient.insert("SCORE", score.toMap());
  }

  Future<List<Score>> getAllScores() async {
    var dbClient = await db;
    var result = await dbClient.query("SCORE");
    return List.generate(result.length, (index) {
      return Score(
        score_id: result[index]["score_id"],
        name: result[index]["name"],
        category: result[index]["category"],
        score: result[index]["score"],
      );
    });
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

class User {
  int id;
  String name;
  int age;
  String email;
  String password;

  User(this.id, this.name, this.age, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "email": email,
      "password": password,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    age = map["age"];
    email = map["email"];
    password = map["password"];
  }
}

class Score {
  int score_id;
  String name;
  String category;
  int score;

  Score({this.score_id, this.name, this.category, this.score});

  Map<String, dynamic> toMap() {
    return {
      "score_id": score_id,
      "name": name,
      "category": category,
      "score": score,
    };
  }
}
