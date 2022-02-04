import 'dart:convert';
import 'package:booking_appointments/classes/appointment.dart';
import 'package:booking_appointments/classes/appointment_hour.dart';
import 'package:booking_appointments/classes/doctor.dart';
import 'package:booking_appointments/classes/booking.dart';
import 'package:booking_appointments/classes/lab.dart';
import 'package:booking_appointments/classes/user.dart';
import 'package:booking_appointments/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Connection {
  var baseUrl = 'http://10.0.2.2:8080';
  //var baseUrl = 'http://192.168.1.109:8080';

  Future<List<Doctor>> getDoctorList() async {
      var url = '$baseUrl/test/sendData/sendData.php';
      var map = <String, dynamic>{};
      map['action'] = 'getDoctorList';
      final response = await http.post(Uri.parse(url), body: map);
      var doctorList = <Doctor>[];
      if (response.statusCode == 200){
        var doctorsListJson = json.decode(response.body);
        for (var doctorJson in doctorsListJson){
          doctorList.add(Doctor.fromJson(doctorJson));
        }
      }
      return doctorList;
  }

  Future<List<Doctor>> getDoctorClinicList(String type) async {
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action': 'getDoctorClinicList',
      'type': type,
    });
    var doctorList = <Doctor>[];
    if (response.statusCode == 200){
      var doctorsListJson = json.decode(response.body);
      for (var doctorJson in doctorsListJson){
        doctorList.add(Doctor.fromJson(doctorJson));
      }
    }
    return doctorList;
  }

  Future<List<Booking>>  getUserBookingList(int id) async {
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'getUserbooking',
      'id' : id.toString(),
    });
    var BookingList = <Booking>[];
    if (response.statusCode == 200) {
      var bookingListJson = json.decode(response.body);
      for (var bookJson in bookingListJson) {
        BookingList.add(Booking.fromJson(bookJson));
      }
    }
    return BookingList;
  }

  Future <List<Appointment>> getDoctorAppointment(String doctorName)async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'getDoctorAppointment',
      'doctorName' : doctorName,
    });
    var AppointmentsList = <Appointment>[];
    if (response.statusCode == 200) {
      var appontmentListJson = json.decode(response.body);
      for (var appointmentJson in appontmentListJson) {
        AppointmentsList.add(Appointment.fromJson(appointmentJson));
      }
    }
    return AppointmentsList;
  }

  Future <List<AppointmentHour>> getAvailableDoctorAppointmentHour(String doctorName, String availableDay,String date) async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'getAvailableDoctorAppointmentHour',
      'doctorName' : doctorName,
      'availableDay': availableDay,
      'bookinghistory': date
    });
    var AppointmentsList = <AppointmentHour>[];
    if (response.statusCode == 200) {
      var appontmentListJson = json.decode(response.body);
      for (var appointmentJson in appontmentListJson) {
        AppointmentsList.add(AppointmentHour.fromJson(appointmentJson));
      }
    }
    return AppointmentsList;
  }

  void show_toast() => Fluttertoast.showToast(
    msg: 'Wrong Email or password',
    fontSize: 18
  );

  Future <List<User>> getUserInformation(String user_email, String user_password) async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'getUserInformation',
      'email' : user_email,
      'password': user_password,
    });
    var user = <User>[];
    if (response.statusCode == 200) {
      var userListJson = json.decode(response.body);
      for (var userJson in userListJson) {
        user.add(User.fromJson(userJson));
      }
    }
      return user;
  }



  Future booking(String doctor_name, String day, String history, int hour) async{
    Global g = Global();
    var url = '$baseUrl/test/sendData/sendData.php';
    int? id_user = await g.getLoggedInStatus();
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'bookingUserAppointments',
      'id_user' : id_user.toString(),
      'doctor_name' : doctor_name,
      'availableDay' : day,
      'bookinghistory' : history,
      'availableHour' : hour.toString()
    });
    if (response.statusCode == 200) {
      print('success');
    }
  }

  Future delete_user_booking(int id)async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
        'action' : 'deleteUserBooking',
      'id_booking' : id.toString()
    });
    if (response.statusCode == 200){
      print('success');
    }
  }

  Future <List<Lab>> get_lab_info()async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' : 'getLabInfo'
    });

    var lab = <Lab>[];
    if (response.statusCode == 200) {
      var labListJson = json.decode(response.body);
      for (var labJson in labListJson) {
        lab.add(Lab.fromJson(labJson));
      }
    }
    return lab;
  }

  Future sing_up(String name, String email, String password ) async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' : 'singUp',
      'email' : email,
      'name' : name,
      'password' : password
    });
    if(response.statusCode == 200){
      print ('success');
    }
  }

  Future <List<AppointmentHour>> getAvailableLabHour(String id_lab, String availableDay, String date) async{
    var url = '$baseUrl/test/sendData/sendData.php';
    final response = await http.post(Uri.parse(url), body: {
      'action' :  'getAvailableLabHour',
      'availableDay': availableDay,
      'date': date,
      'id_lab' : id_lab
    });
    var AppointmentsList = <AppointmentHour>[];
    if (response.statusCode == 200) {
      var appontmentListJson = json.decode(response.body);
      for (var appointmentJson in appontmentListJson) {
        AppointmentsList.add(AppointmentHour.fromJson(appointmentJson));
      }
    }
    return AppointmentsList;
  }


  Future labBooking(String availableDay, String availableHour, String day, String id_lab) async{
    Global g = Global();
    var url = '$baseUrl/test/sendData/sendData.php';
    int? id_user = await g.getLoggedInStatus();
    final response = await http.post(Uri.parse(url), body: {
      'action' : 'labBooking',
      'id_user' : id_user.toString(),
      'availableDay' : availableDay,
      'availableHour' : availableHour,
      'day' : day,
      'id_lab' : id_lab
    });
    if (response.statusCode == 200) {
      print('success');
    }
  }


}


