import 'package:booking_appointments/clinics.dart';
import 'package:booking_appointments/global.dart';
import 'package:booking_appointments/home_user.dart';
import 'package:booking_appointments/slide_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {

  Global g = Global();
  String? name = '';

  @override
  void initState() {
    super.initState();
    g.getLoggedInName().then((value) {
      setState(() {
        name=value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Weclome ${name}', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Theme
              .of(context)
              .primaryColor,
        ),
        drawer: Slide_bar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'You can choose to book\nin Clinics OR Labs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height /4 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/clinc.jpg'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeUser(value: 0,index_value: 0,)) );
                  },
                  child: Text('Clinic',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35,color: Colors.white),),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height /4 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/images/lab.jpg'),
                      fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeUser(value: 1,index_value: 1,)) );
                  },
                  child: const Text('Laboratory',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
