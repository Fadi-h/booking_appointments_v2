import 'package:booking_appointments/home_doctor.dart';
import 'package:booking_appointments/home_user.dart';
import 'package:booking_appointments/login.dart';
import 'package:booking_appointments/my_theme.dart';
import 'package:booking_appointments/sign_up.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: myTheme.myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=> Login(),
        '/HomeDoctor': (context)=> HomeDoctor(),
        'HomeUser': (context)=> HomeUser(value: 2,index_value: 2,),
        '/SignUp': (context)=> Sign_up(),
      },
    );
  }
}
