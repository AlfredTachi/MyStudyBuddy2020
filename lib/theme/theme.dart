import 'package:flutter/material.dart';


  ThemeData baselight() {  
  ThemeData baselight = ThemeData.light();
  return baselight.copyWith(


    primaryColor: Colors.orange,
    // iconTheme: IconThemeData(
    //   color: ,
    //   size: 
    // )

    textTheme:TextTheme(
    
    title: TextStyle(color: Colors.black,fontSize: 25,fontFamily: 'Roboto'),
    body1: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Roboto'),
    body2: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Roboto'),
    ) ,
    appBarTheme: AppBarTheme(color: Colors.orange, textTheme: TextTheme(title:TextStyle(color: Colors.white,fontSize: 22))),
    indicatorColor:Colors.deepOrange ,
    scaffoldBackgroundColor:Colors.white ,
    accentColor: Colors.deepOrangeAccent,
    buttonColor: Colors.orange,
    backgroundColor: Colors.white,
    

  );}

  ThemeData basedark() { 

  ThemeData basedark = ThemeData.dark();
  return basedark.copyWith(
    primaryColor: Colors.blue,
    // iconTheme: IconThemeData(
    //   color: ,
    //   size: 
    // )
    textTheme:TextTheme(
    
    title: TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'Roboto Light'),
    body1: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Roboto Light'),
    body2: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Roboto Light'),
    ) ,
    appBarTheme: AppBarTheme(color: Colors.black, textTheme: TextTheme(title:TextStyle(color: Colors.white,fontSize: 22))),
    // indicatorColor:Colors.blue ,
    // scaffoldBackgroundColor:Colors.black ,
    // accentColor: Colors.blue,
    // buttonColor: Colors.blue,
    // backgroundColor: Colors.blue,
    // cardColor: Colors.black,
    brightness: Brightness.dark,

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
