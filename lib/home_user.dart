import 'package:booking_appointments/clinics.dart';
import 'package:booking_appointments/doctor_list.dart';
import 'package:booking_appointments/icons/my_icons1_icons.dart';
import 'package:booking_appointments/icons/my_icons2_icons.dart';
import 'package:booking_appointments/lab_list.dart';
import 'package:booking_appointments/main_page.dart';
import 'package:booking_appointments/my_booking.dart';
import 'package:booking_appointments/slide_bar.dart';
import 'package:booking_appointments/test.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'icons/my_icons_icons.dart';


class HomeUser extends StatefulWidget {
  int value;
  int index_value;
  HomeUser({Key? key, required this.value, required this.index_value}) : super(key: key);

  @override
  _HomeUserState createState() => _HomeUserState(value,index_value);
}

class _HomeUserState extends State<HomeUser> {
  int value;
  int index_value;
  _HomeUserState(this.value,this.index_value);
  final navigationKey = GlobalKey<CurvedNavigationBarState>();


  @override
  void initState() {
    int index = index_value;
  }

  final screens = [
    const Clinics(),
    const LabList(),
    const MainPage(),
    const BookingList(),
    const DoctorList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[value],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          child: curved(),
        ),
    );

  }

  Widget curved(){
    return CurvedNavigationBar(
      key: navigationKey,
      backgroundColor: Colors.white,
      color: const Color(0xff34badd),
      items: const [
        Icon(MyIcons2.stethoscope, size: 35),
        Icon(MyIcons1.microscope, size: 35),
        Icon(Icons.add, size: 30),
        Icon(Icons.calendar_today_outlined, size: 27),
        Icon(MyIcons.doctor, size: 36),
      ],
      index: index_value,
      height: 50,
      onTap: (index)=> setState(() {
        this.value = index;
      }),
    );
  }

}


