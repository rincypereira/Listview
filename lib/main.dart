import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
      home: new HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(Uri.parse("https://www.json-generator.com/api/json/get/cpYqtqNBXC?indent=2"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["name"]);

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("News Article"),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding:const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: new Card(
                child: ListTile(
                  onTap: (){
                    NetworkImage(data[index]["url"]);
                  },
                  title: new Text(data[index]["news_id"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  subtitle: Text(data[index]["name"]),

                )
            ),
          );
        },
      ),
    );
  }
}
