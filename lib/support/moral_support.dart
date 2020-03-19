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
    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
        Container(
          color: Colors.orange,
          child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: OutlineButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Icon(
                            Icons.arrow_back,
                            size: 36,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                   Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(left:20, top: 3, bottom: 3),
                          child: Text("Es wird alles gut!",style: TextStyle(fontSize: 25),))),
                ],
              ),
        ),
        Center(
          child: FutureBuilder(
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
                        child: Text("Hilfe!"),
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
        ),
          ],
        ),
      ),
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
