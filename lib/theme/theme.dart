import 'package:flutter/material.dart';


  ThemeData baselight() {  
  ThemeData baselight = ThemeData.light();
  return baselight.copyWith(


    primaryColor: Colors.orange,
    textTheme:TextTheme(
    
    title: TextStyle(color: Colors.black,fontSize: 25,fontFamily: 'Roboto'),
    body1: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Roboto'),
    body2: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Roboto'),
    ) ,
    appBarTheme: AppBarTheme(color: Colors.orange, textTheme: TextTheme(title:TextStyle(color: Colors.white,fontSize: 22))),
    indicatorColor:Colors.deepOrange ,
    scaffoldBackgroundColor:Colors.white ,
    accentColor: Colors.deepOrangeAccent,
  );}

  ThemeData basedark() { 

  ThemeData basedark = ThemeData.dark();
  return basedark.copyWith(

    textTheme:TextTheme(
    
    title: TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'Roboto'),
    body1: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Roboto'),
    body2: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Roboto'),
    ) ,
    //appBarTheme: AppBarTheme(color: Colors.black, textTheme: TextTheme(title:TextStyle(color: Colors.white,fontSize: 22))),
   // scaffoldBackgroundColor: Colors.grey,
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColorBrightness: Brightness.dark,
    

  );}



class ThemeChanger with ChangeNotifier{
  ThemeData _themeData;

    ThemeChanger(this._themeData);
    getTheme() => _themeData;
    setTheme(ThemeData theme){
      _themeData = theme;

      notifyListeners();
    }

}
