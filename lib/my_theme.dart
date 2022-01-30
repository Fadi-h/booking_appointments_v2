import 'package:flutter/material.dart';


MyTheme myTheme = MyTheme();

class MyTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get myTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }



  static ThemeData get lightTheme  {
    return ThemeData(
        fontFamily: 'fontOne',
        primaryColor: Color(0xff34badd),
        backgroundColor: Color(0xff34badd),
        scaffoldBackgroundColor: Color(0xff34badd),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Color(0xff34badd)),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.black87,
        backgroundColor: Colors.black,
        accentColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        )
    );
  }
}

