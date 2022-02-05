import 'package:booking_appointments/choose_time_lab.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingLadDate extends StatefulWidget {
  int value;
  BookingLadDate({Key? key, required this.value}) : super(key: key);

  @override
  _BookingLadDateState createState() => _BookingLadDateState(value);
}

class _BookingLadDateState extends State<BookingLadDate> {
  int value;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  _BookingLadDateState(this.value);


  cheakBooking(){
    if(!selectedDay.isBefore(DateTime.now())){
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Choose time', style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Theme.of(context).primaryColor,),
      body: SafeArea(
        child:  Column(
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
          print(focusedDay);
          String day = DateFormat.E().format(focusedDay);
          String date = DateFormat('y-M-d').format(focusedDay);
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChooseTimeLab(value: day ,value1: date,value2: value.toString(),)));
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
