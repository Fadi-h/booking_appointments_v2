import 'package:booking_appointments/connection.dart';
import 'package:flutter/material.dart';

class ChooseTimeLab extends StatefulWidget {
  String value;
  String value1;
  String value2;
  ChooseTimeLab({Key? key, required this.value, required this.value1,required this.value2}) : super(key: key);


  @override
  _ChooseTimeLabState createState() => _ChooseTimeLabState(value, value1,value2);
}

late List<dynamic> _appointments;

class _ChooseTimeLabState extends State<ChooseTimeLab> {
  String value;
  String value1;
  String value2;
  int? hour;
  _ChooseTimeLabState(this.value,this.value1,this.value2);
  Connection connection = Connection();


  _getAvailableLabHour(String id_lab, String availableDay, String date){
    Connection connection = Connection();
    connection.getAvailableLabHour(id_lab,availableDay, date).then((value){
      setState(() {
        _appointments.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _appointments = [];
    _getAvailableLabHour(value2, value, value1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Choose time',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Theme.of(context).primaryColor,centerTitle: true,),
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: _appointments.length,
            itemBuilder: (context, index){
              hour = _appointments[index].availableHour;
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
                            await connection.labBooking(value, _appointments[index].availableHour.toString(), value1, value2);
                            setState(() {
                              _appointments = [];
                              _getAvailableLabHour(value2,value,value1);
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
        ),
      ),
    );
  }
}
