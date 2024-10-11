import 'package:flutter/material.dart';

class AppThemes {
  
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
    
  );

  
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.black,
    
  );

  
  static const List<Color> highlightColors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
  ];


}
