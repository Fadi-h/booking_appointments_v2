
import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/icons/my_icons_icons.dart';
import 'package:flutter/material.dart';
import 'classes/doctor.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({Key? key}) : super(key: key);

  @override
  _HomeDoctorState createState() => _HomeDoctorState();
}

late List<dynamic> _doctors;

class _HomeDoctorState extends State<HomeDoctor> {


  _getDoctorList() {
    Connection conn = Connection();
    conn.getDoctorList().then((value){
      setState(() {
        _doctors.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _doctors = [];
    _getDoctorList();
  }

  String? name;
  String? clinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (context, index) {
          index += 1;
          name = _doctors[index - 1].name;
          clinic = _doctors[index - 1].clinic;
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
              ),
              margin: const EdgeInsets.only(top: 10),
              height: 100,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    '$index',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Name: $name',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)
                      ),
                      SizedBox(height: 10),
                      Text(
                          'Clinic: $clinic',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 10),

                    ],
                  ),
                  SizedBox(width: 30),
                  Icon(
                    MyIcons.doctor,
                    color: Colors.white.withOpacity(0.9),
                    size: 50,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}

