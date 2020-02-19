import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:validators/validators.dart' as validators;

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: MyTextFormField(
                hintText: 'Vorname',
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: MyTextFormField(
                hintText: 'Nachname',
              ),
            ),
          ],
        ),
        MyTextFormField(
          hintText: 'E-Mail',
          isEmail: true,
          contentpadding: 15.0,
        ),
        MyTextFormField(
          hintText: 'Deine Nachricht',
          maxlines: 5,
        ),
        RaisedButton(
            color: Colors.blueAccent,
            child: Text('Nachricht senden',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {
              print('Nachricht gesendet.');
            })
      ]),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final double contentpadding;
  final int maxlines;

  MyTextFormField(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isEmail = false,
      this.maxlines = 1,
      this.contentpadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[800]),
          contentPadding: EdgeInsets.all(5),
          filled: true,
          fillColor: Colors.grey[300],
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
