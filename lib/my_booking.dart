
import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/global.dart';
import 'package:flutter/material.dart';
import 'classes/doctor.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  _BookingListState createState() => _BookingListState();
}

late List<dynamic> _booking;

class _BookingListState extends State<BookingList> {

  Global g = Global();
  int? id;
  bool? delete_book;
  Connection connection = Connection();
  _getBookingList(int id) {
    Connection conn = Connection();
    conn.getUserBookingList(id).then((value){
      setState(() {
        _booking.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _booking = [];
    g.getLoggedInStatus().then((value) => {
      id = value,
    _getBookingList(id!)
    });
  }

  int? time;
  String? doctorName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Appiontments', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _booking.length,
        itemBuilder: (context, index) {
          index += 1;
          time = _booking[index - 1].bookingHour;
          doctorName = _booking[index - 1].doctorName;
          //doctor = _booking[index - 1].doctor;
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
                          'Time: $time',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)
                      ),
                      SizedBox(height: 10),
                      Text(
                          'Doctor: $doctorName',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TextButton(
                      //   onPressed: (){
                      //
                      //   },
                      //   child: const Icon(Icons.edit, color: Colors.white,size: 25,),
                      // ),
                      TextButton(
                        onPressed: ()async {
                          showAlertDialog(context, index);
                        },
                        child: const Icon(Icons.delete, color: Colors.white,size: 25,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  showAlertDialog(BuildContext context, index){
    // set up the button
    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed: () {
        setState(() {
          delete_book = false;
        });
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("Yes", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed: () async {
        await connection.delete_user_booking(_booking[index -1].idClinicBook);
        setState(() {
          _booking = [];
          g.getLoggedInStatus().then((value) => {
            id = value,
            _getBookingList(id!)
          });
        });
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
      content: Text("Do you went\nto delete this appointment?",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

