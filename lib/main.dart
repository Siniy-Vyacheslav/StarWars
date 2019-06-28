import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StarWarsData(),
    );
  }
}

class StarWarsData extends StatefulWidget {
  @override
  State createState() => StarWarsState();
}

class StarWarsState extends State<StarWarsData> {
  final String url = 'https://swapi.co/api/starships';
  List data;

  Future<String> getSWData() async {
    var res = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept': 'application/json'},
    );

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody['results'];
    });

    return 'Success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Starships'),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Name: '),
                          Text(
                            data[index]['name'],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Model: '),
                          Text(
                            data[index]['model'],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Cargo Capacity: '),
                          Text(
                            data[index]['cargo_capacity'],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
