import 'package:app_quiz/sqlite/DatabaseQuiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPlayers extends StatefulWidget {
  DatabaseQuiz database;

  @override
  _ListPlayersState createState() => _ListPlayersState();
}

class _ListPlayersState extends State<ListPlayers> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("List Champions"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/categories");
            }),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: widget.database.getAllScores(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return Row(
                          children: <Widget>[
                            Expanded(child: Text(snapshot.data[index].name)),
                            Expanded(
                                child: Text(
                                    snapshot.data[index].score.toString())),
                            Expanded(
                                child: Text(snapshot.data[index].category)),
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: Text("No Data"),
                  );
                }
              },
            )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.database = new DatabaseQuiz();
  }
}
