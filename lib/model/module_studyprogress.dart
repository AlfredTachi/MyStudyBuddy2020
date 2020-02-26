import 'package:flutter/material.dart';

class Module {
  int id;
  String title;

  Module(
    this.id,
    this.title,
  );

  Widget module() {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Color(0xFF013D62),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    offset: Offset(
                      0.0,
                      1.5,
                    ),
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Center(
                          child: Text(title,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            )));
  }
}
