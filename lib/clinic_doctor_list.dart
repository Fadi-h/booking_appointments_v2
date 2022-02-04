
import 'package:booking_appointments/booking_page.dart';
import 'package:booking_appointments/connection.dart';
import 'package:flutter/material.dart';
import 'classes/doctor.dart';

class ClinicDoctorList extends StatefulWidget {
  String value;
  ClinicDoctorList({Key? key, required this.value}) : super(key: key);

  @override
  _ClinicDoctorListState createState() => _ClinicDoctorListState(value);
}

late List<dynamic> _doctors;

class _ClinicDoctorListState extends State<ClinicDoctorList> {

  String value;
  _ClinicDoctorListState(this.value);

  _getDoctorCinicList(String type) {
    Connection conn = Connection();
    conn.getDoctorClinicList(type).then((value){
      setState(() {
        _doctors.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _doctors = [];
    _getDoctorCinicList(value);
  }

  String? name;
  String? clinic;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose A Doctor',style: TextStyle(fontWeight: FontWeight.bold),),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      '$index',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                  TextButton(
                      onPressed: (){
                        String n = _doctors[index - 1].name;
                        print (index - 1);
                        print(n);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookingPage(doctorName: n.toString())));
                      },
                      child: Icon(Icons.file_download_done, color: Colors.white,),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}

