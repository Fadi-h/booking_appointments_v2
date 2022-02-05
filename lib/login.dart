import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/global.dart';
import 'package:booking_appointments/home_doctor.dart';
import 'package:booking_appointments/home_user.dart';
import 'package:booking_appointments/sign_up.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

late List<dynamic> _user;

class _LoginPage extends State<Login> {

  Global g = Global();
  final formGlobalKey = GlobalKey<FormState>();
  int? accountId = -1;
  var _username;
  var _password;
  final email = TextEditingController();
  final pass = TextEditingController();
  bool show = false;

  _getUserInformation(String user_email, String user_password) async{
    Connection conn = Connection();
    await conn.getUserInformation(user_email, user_password).then((value){
      setState(() {
        _user.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    g.getLoggedInStatus().then((value){
      if(value == -1){
        print(value);
      }else if (value! > 20000){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_)=> HomeUser(value: 2,index_value: 2)));
        print(value);
      }else if(value > 10000 && value < 20001){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_)=> HomeDoctor()));
        print(value);
      }
    });
    _user = [];
  }


  checkAccount(context, int id) async{
    try {
      if (id != -1) {
        if (id  > 20000) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_)=> HomeUser(value: 2,index_value: 2,)));
        }else if(id > 10000 && id < 20001){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_)=> HomeDoctor()));
        }else if (id > 5001 && id < 10001){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_)=> HomeDoctor()));
        }
      }else if (id == -1){
        print ('Login page');
      }
    }on Exception catch(_){
    }
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
                  image: const AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                )),
          ),
          Form(
            key: formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ClipPath(
                        clipper: BackgroundClipper1(),
                        child: Container(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                      ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                          const Text('Booking\nappointments',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    height: 80,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: email,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Username cannot be empty';
                        } else if (email.length < 4) {
                          return 'Username must be al least 4 characters long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                        prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.white)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    height: 80,
                    child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        obscureText: show,
                        controller: pass,
                        validator: (pass) {
                          if (pass!.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              show
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                show = !show;
                              });
                            },
                          ),
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
                  const SizedBox(height: 25),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () async {
                        print('55555555555');
                        _username = email.text;
                        _password = pass.text;
                        print(_username);
                        print(_password);
                        await _getUserInformation(_username, _password);
                        if (_username.isEmpty && _password.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  content: const Text('Please fill your email and password',
                                    textAlign: TextAlign.center,
                                    style: TextStyle( fontSize: 16),
                                  )
                              )
                          );
                        }
                        else if(_user.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Theme.of(context).primaryColor,
                                content: const Text('wrong email or password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle( fontSize: 16),
                                )
                              )
                          );
                        }
                        print(_user[0].id);
                        int id = _user[0].id;
                        setState(() {
                          g.storeLoggedInID(_user[0].id);
                          g.storeLoggedInName(_user[0].name);
                        });
                        checkAccount(context,id);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account yet?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (_)=> Sign_up())
                          );
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void alert(BuildContext context) {
    var alertDialog = const AlertDialog(
      title: Text('Wrong Info'),
      content: Text('Your Email or Password is wrong\nPlease cheak your Info'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

class BackgroundClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 70);
    var firstController = Offset(size.width / 1.3, size.height + 30);
    var endFirstCurve = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(firstController.dx, firstController.dy,
        endFirstCurve.dx, endFirstCurve.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    var firstController = Offset(size.width / 5, size.height);
    var endFirstCurve = Offset(size.width / 2.25, size.height - 35);
    path.quadraticBezierTo(firstController.dx, firstController.dy,
        endFirstCurve.dx, endFirstCurve.dy);

    var secondController = Offset(size.width / 1.3, size.height - 80);
    var endSecondCurve = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondController.dx, secondController.dy,
        endSecondCurve.dx, endSecondCurve.dy);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
