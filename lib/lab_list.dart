import 'package:booking_appointments/booking_lab_date.dart';
import 'package:booking_appointments/booking_page.dart';
import 'package:booking_appointments/connection.dart';
import 'package:booking_appointments/icons/my_icons_icons.dart';
import 'package:flutter/material.dart';

class LabList extends StatefulWidget {
  const LabList({Key? key}) : super(key: key);

  @override
  _LabListState createState() => _LabListState();
}


late List<dynamic> _lab;

class _LabListState extends State<LabList> {

  String? name;

  _getLabInfo(){
    Connection conn = Connection();
    conn.get_lab_info().then((value) {
      setState(() {
        _lab.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _lab = [];
    _getLabInfo();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labs List', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _lab.length,
        itemBuilder: (context, index) {
          index += 1;
          name = _lab[index - 1].labName;
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
                  Text(
                      'Name: $name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)
                  ),
                  IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingLadDate(value: _lab[index - 1].id,)));
                  },
                      icon: Icon(Icons.check,color: Colors.white,))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
