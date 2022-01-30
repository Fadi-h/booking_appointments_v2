import 'package:booking_appointments/choose_time_list.dart';
import 'package:booking_appointments/classes/booking.dart';
import 'package:booking_appointments/connection.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class BookingPage extends StatefulWidget {

  String doctorName;
  BookingPage({Key? key, required this.doctorName}) : super(key: key);
  @override
  _BookingPageState createState() => _BookingPageState(doctorName);
}

late List<dynamic> _appointments;

class _BookingPageState extends State<BookingPage> {


  String doctorName;
  _BookingPageState(this.doctorName);

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  _getAppointmentsList(String name) {
    Connection conn = Connection();
    conn.getDoctorAppointment(name).then((value){
      setState(() {
        _appointments.addAll(value);
      });
    });
  }

  bool checkDay(){
    for (int i = 0; i< _appointments.length; i++){
      if (DateFormat.E().format(focusedDay) == _appointments[i].availableDay) {
        return true;
      }
    }
    return false;
  }

  cheakBooking(){
    if(!selectedDay.isBefore(DateTime.now())){
      if(checkDay()){
        return true;
      }
    }
    return false;

  }

  @override
  void initState() {
    super.initState();
    _appointments = [];
    _getAppointmentsList(doctorName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Date", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color(0xff34badd),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(2020),
              lastDay: DateTime(2025),
            startingDayOfWeek: StartingDayOfWeek.sunday,
              //action------------------------------------------------
              onDaySelected: (DateTime selectDay, DateTime focusDay){
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                  if (focusDay.isBefore(DateTime.now())){
                    showAlertDialog(context);
                  }
              },
              headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), formatButtonVisible: false, titleCentered: true),
              daysOfWeekStyle: const DaysOfWeekStyle(weekdayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.blueGrey)),
              //style ----------------------------
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                defaultTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Color(0xff34badd),
                  shape: BoxShape.circle,
                ),
              ),
              selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
              },
            ),
            SizedBox(height: 100,),
            !cheakBooking() ? Text(' ') : bookingButton(),
          ],
        ),
      ),
    );
  }



  Widget bookingButton(){
    return Container(
      height: 70,
      width: 130,
      decoration: BoxDecoration(
          color: Color(0xff34badd),
        borderRadius: BorderRadius.circular(15)
      ),
      child:TextButton(
        onPressed: () async {
          print(doctorName);
          print(focusedDay);
          String day = DateFormat.E().format(focusedDay);
          String date = DateFormat('y-M-d').format(focusedDay);
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChooseTime(value: doctorName, value2: day ,value3: date)));
        },
        child: const Text(
          'Book',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
      content: Text("This time is old \n You can't book in this day",style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
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
