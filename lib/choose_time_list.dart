import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/home_user.dart';
import 'package:flutter/material.dart';

class ChooseTime extends StatefulWidget {
  String value;
  String value2;
  String value3;
  ChooseTime({Key? key, required this.value, required this.value2,required this.value3}) : super(key: key);

  @override
  _ChooseTimeState createState() => _ChooseTimeState(value, value2, value3);
}

late List<dynamic> _appointment;


class _ChooseTimeState extends State<ChooseTime> {
  Connection conn = Connection();
  String value;
  String value2;
  String value3;
  _ChooseTimeState(this.value, this.value2,this.value3);

  _getAvailableAppointmentTime(String doctorName, String day, String date) {
    Connection conn = Connection();
    conn.getAvailableDoctorAppointmentHour(doctorName, day, date).then((value){
      setState(() {
        _appointment.addAll(value);
      });
    });
  }


  @override
  void initState() {
    super.initState();
    _appointment = [];
    _getAvailableAppointmentTime(value,value2,value3);
  }

  int? hour;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeUser(index_value: 2,value: 2)),
            );
          },
              icon: Icon(Icons.home))
        ],
        title: Text('Choose A Time',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: _appointment.length == 0 ?
      Center(
        child: Text('All appointments are booked\non this day for this doctor',
          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
      ) :
      ListView.builder(
        itemCount: _appointment.length,
        itemBuilder: (context, index) {
          //index += 1;
          hour = _appointment[index].availableHour;
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
                          'Hour: $hour',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  TextButton(
                    onPressed: ()async{
                      await conn.booking(value,value2, value3, _appointment[index].availableHour);
                      setState(() {
                        _appointment = [];
                        _getAvailableAppointmentTime(value,value2,value3);
                      });
                    },
                    child: const Icon(Icons.check, color: Colors.white,)
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}

