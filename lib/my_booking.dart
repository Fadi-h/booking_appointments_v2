
import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/global.dart';
import 'package:booking_appointments/slide_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classes/doctor.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  _BookingListState createState() => _BookingListState();
}

late List<dynamic> _booking;
late List<dynamic> _bookingLab;

class _BookingListState extends State<BookingList> {

  Global g = Global();
  int? id;
  String? timeLab;
  bool? delete_book;
  String? day;
  List<bool> select = [false, true];

  Connection connection = Connection();

  _getBookingList(int id) {
    Connection conn = Connection();
    conn.getUserBookingList(id).then((value){
      setState(() {
        _booking.addAll(value);
      });
    });
  }

  _getBookingListLab(int id){
    Connection conn = Connection();
    conn.getUserLabBooking(id).then((value){
      setState(() {
        _bookingLab.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _booking = [];
    _bookingLab = [];
    g.getLoggedInStatus().then((value) => {
      id = value,
    _getBookingList(id!)
    });
    g.getLoggedInStatus().then((value) => {
      id = value,
      _getBookingListLab(id!)
    });
  }

  int? time;
  String? doctorName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Slide_bar(),
        appBar: AppBar(
          title: Text('Your Appiontments', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        body: _booking.length == 0
            ?  Stack(
              children: [
                Center(
          child: Text('You don\'t have any\nvalid booking',
                textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1,color: Theme.of(context).primaryColor)
                  ),
                  child: ToggleButtons(
                    isSelected: select,
                    fillColor: Theme.of(context).primaryColor,
                    selectedColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    renderBorder: false,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.5 - 5,
                        child: Center(child: Text('Lab',style: TextStyle(fontWeight: FontWeight.bold,),),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.5,
                        child: Center(child: Text('Clinic',style: TextStyle(fontWeight: FontWeight.bold, ),),),
                      ),
                    ],
                    onPressed: (int newIndex){
                      setState((){
                        if (newIndex == 0){
                          select[0] = true;
                          select[1] = false;
                        }else{
                          select[0] = false;
                          select[1] = true;
                        }
                        // for(int index  = 0; index < select.length; index++){
                        //   if (index == newIndex){
                        //     select[index] = true;
                        //   }else{
                        //     select[index] = false;
                        //   }
                        // }
                      });
                    },
                  ),
                ),
              ],
            )
        : Stack(
          children: [
            select[0] == false ?
            Container(
              padding: EdgeInsets.only(top: 50),
              child: ListView.builder(
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
            )
                : _bookingLab.length == 0
                ? Stack(
              children: [
                Center(
                  child: Text('You don\'t have any\nvalid booking',
                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1,color: Theme.of(context).primaryColor)
                  ),
                  child: ToggleButtons(
                    isSelected: select,
                    fillColor: Theme.of(context).primaryColor,
                    selectedColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    renderBorder: false,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.5 - 5,
                        child: Center(child: Text('Lab',style: TextStyle(fontWeight: FontWeight.bold,),),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width *0.5,
                        child: Center(child: Text('Clinic',style: TextStyle(fontWeight: FontWeight.bold, ),),),
                      ),
                    ],
                    onPressed: (int newIndex){
                      setState((){
                        if (newIndex == 0){
                          select[0] = true;
                          select[1] = false;
                          _booking = [];
                          g.getLoggedInStatus().then((value) => {
                            id = value,
                            _getBookingList(id!)
                          });
                        }else{
                          select[0] = false;
                          select[1] = true;
                          _booking = [];
                          g.getLoggedInStatus().then((value) => {
                            id = value,
                            _getBookingList(id!)
                          });
                        }
                        // for(int index  = 0; index < select.length; index++){
                        //   if (index == newIndex){
                        //     select[index] = true;
                        //   }else{
                        //     select[index] = false;
                        //   }
                        // }
                      });
                    },
                  ),
                ),
              ],
            )
                :Container(
              padding: EdgeInsets.only(top: 50),
              child: ListView.builder(
                itemCount: _bookingLab.length,
                itemBuilder: (context, index) {
                  index += 1;
                  timeLab = _bookingLab[index - 1].bookingHour.toString();
                  day = _bookingLab[index - 1].bookingDay;
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
                                  '$day',
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
                                  showAlertDialog1(context, index);

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
            ) ,
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border.all(width: 1,color: Theme.of(context).primaryColor)
              ),
              child: ToggleButtons(
                isSelected: select,
                fillColor: Theme.of(context).primaryColor,
                selectedColor: Colors.white,
                color: Theme.of(context).primaryColor,
                renderBorder: false,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width *0.5 - 5,
                    child: Center(child: Text('Lab',style: TextStyle(fontWeight: FontWeight.bold,),),),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width *0.5,
                    child: Center(child: Text('Clinic',style: TextStyle(fontWeight: FontWeight.bold, ),),),
                  ),
                ],
                onPressed: (int newIndex){
                  setState((){
                    if (newIndex == 0){
                      select[0] = true;
                      select[1] = false;
                    }else{
                      select[0] = false;
                      select[1] = true;
                    }
                    // for(int index  = 0; index < select.length; index++){
                    //   if (index == newIndex){
                    //     select[index] = true;
                    //   }else{
                    //     select[index] = false;
                    //   }
                    // }
                  });
                },
              ),
            ),
          ],
        ),
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
  showAlertDialog1(BuildContext context, index){
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
        await connection.delete_user_Labbooking(_bookingLab[index -1].id_labBooking);
        setState(() {
          _bookingLab = [];
          g.getLoggedInStatus().then((value) => {
            id = value,
            _getBookingListLab(id!)
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

