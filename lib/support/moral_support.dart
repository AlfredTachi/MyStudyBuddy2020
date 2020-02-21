import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MoralSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MoralSupportState();
}

class MoralSupportState extends State<MoralSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Es wird alles gut!"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: getDogImage(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                DogImage img = snap.data;
                return Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 500,
                      child: Image.network(
                        img.url,
                      ),
                    ),
                    RaisedButton(
                        child: Text("Hife!"),
                        onPressed: () {
                          setState(() {});
                        })
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      )),
    );
  }

  Future<DogImage> getDogImage() async {
    final http.Response response =
        await http.get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      return DogImage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Dog Image!!');
    }
  }
}

class DogImage {
  String url;
  String status;

  DogImage({this.url, this.status});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(
      url: json["message"],
      status: json["status"],
    );
  }
}
