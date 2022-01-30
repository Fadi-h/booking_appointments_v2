
import 'package:booking_appointments/connection.dart';
import 'package:flutter/material.dart';
import 'classes/doctor.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}


class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
       child: Text('test'),
      )
    );
  }


}

