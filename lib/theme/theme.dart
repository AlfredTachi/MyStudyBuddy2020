import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

ThemeData baselight() {
  ThemeData baselight = ThemeData.light();
  return (Platform.isIOS)
      ? ThemeData(
          fontFamily: "SF",
          accentColor: CupertinoColors.activeOrange,
          indicatorColor: CupertinoColors.activeOrange,
          primaryColor: CupertinoColors.activeOrange,
          scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
          appBarTheme: AppBarTheme(brightness: Brightness.light))
      : baselight.copyWith(
          primaryColor: Colors.orange,
          textTheme: TextTheme(
            subhead: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'Roboto'),
            title: TextStyle(
                color: Colors.black, fontSize: 25, fontFamily: 'Roboto'),
            body1: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'Roboto'),
            body2: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'Roboto'),
          ),
          appBarTheme: AppBarTheme(
              color: Colors.orange,
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 22))),
          indicatorColor: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.deepOrangeAccent,
        );
}

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);
  ThemeData getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
