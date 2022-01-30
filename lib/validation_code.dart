import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ValidationCode extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ValidationCode();
  }

}
class _ValidationCode extends State<ValidationCode> {
  var code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 120, 0, 30),
                child: const Text(
                    'Verity Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                ),
              const Text('Please enter the verification code we\nsent to your email address',
                textAlign: TextAlign.center,
                style: TextStyle( fontWeight: FontWeight.bold , fontSize: 16 ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 70),
                child: TextField(
                  controller: code,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.red)
                    ),
                    hintText: 'ENTER CODE',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff34badd),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(
                    color: Color(0xff34badd), borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async{

                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}