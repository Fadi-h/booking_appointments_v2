import 'package:booking_appointments/global.dart';
import 'package:booking_appointments/login.dart';
import 'package:booking_appointments/my_theme.dart';
import 'package:booking_appointments/unvailed_booking.dart';
import 'package:flutter/material.dart';

class Slide_bar extends StatelessWidget {
  Global g = Global();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.check, color: Theme.of(context).primaryColor),
              title: Text('unValid booking', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_)=> unvailedBooking()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Theme.of(context).primaryColor),
              title: Text('Info', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).primaryColor,),
              title: Text('Log out', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
              onTap: (){
                g.storeLoggedInID(-1);
                g.storeLoggedInName('');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_)=> Login()));
              },
            ),
          ],
        ),
      ),
    );
  }
}