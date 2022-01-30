import 'package:booking_appointments/clinic_doctor_list.dart';
import 'package:booking_appointments/connection.dart';
import 'package:flutter/material.dart';

class Clinics extends StatefulWidget {
  const Clinics({Key? key}) : super(key: key);

  @override
  _ClinicsState createState() => _ClinicsState();
}

late List<dynamic> _doctors = [];

class _ClinicsState extends State<Clinics> {
  var clinicIcon = ['bone.png','ears.png','heart.png','kidney.png','lungs.png','skin.png','stomach.png','tooth.png','view.png'];

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Column(
                children: [
                  Align(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  const Text(
                    'Choose Clinics',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    String icon = clinicIcon[index];
                    return RawMaterialButton(
                      padding: const EdgeInsets.all(3),
                      onPressed: () async {
                        List c = icon.split('.');
                        String t = c[0].toString();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClinicDoctorList(value: t)
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 0.5,
                              offset: const Offset(
                                  1, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset("assets/clinicImages/$icon"),
                        ),
                      ),
                    );
                  },
                  itemCount: clinicIcon.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
