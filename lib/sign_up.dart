import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/home_user.dart';
import 'package:booking_appointments/validation_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  final _formKey = GlobalKey<FormState>();
  Connection connection = Connection();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var confirmpass = TextEditingController();
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: const AssetImage("assets/images/back1.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            )),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 45)),
                    SizedBox(height: 40),
                    Container(
                      height: 80,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                          controller: firstName,
                          validator: (firstName) {
                            if (firstName!.isEmpty) {
                              return 'Username cannot be empty';
                            } else if (firstName.length < 4) {
                              return 'Username must be al least 4 characters long';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.white)),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              labelText: 'Name',
                              hintText: 'Enter Your Name',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          keyboardType: TextInputType.name,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: email,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'email is empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.white)),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              labelText: 'Email',
                              hintText: 'Enter Your valid Email',
                              hintStyle: TextStyle(color: Colors.white)
                          ),
                          keyboardType: TextInputType.emailAddress),
                    ),
                    Container(
                      height: 80,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: pass,
                          validator: (pass) {
                            if (pass!.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.white)),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(color: Colors.white),
                          ),
                          keyboardType: TextInputType.visiblePassword),
                    ),
                    Container(
                      height: 80,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: confirmpass,
                          validator: (confirmpass) {
                            if (confirmpass != pass.value.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Colors.white)),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Your Password',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                          keyboardType: TextInputType.name),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            print(firstName.text);
                            print(email.text);
                            print(pass.text);
                            await connection.sing_up(firstName.text, email.text, pass.text);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_)=> HomeUser(value: 2, index_value: 2)));
                          }
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff34badd),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void alert(BuildContext context) {
    var alertDialog = const AlertDialog(
      title: Text('Warning'),
      content: Text('There is an error in your data'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }


}
