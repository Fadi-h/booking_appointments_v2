

class UnvailedBooking {
  int id_booking;
  String day;
  int hour;
  String date;
  String doctorName;

  UnvailedBooking({required this.day, required this.hour, required this.date, required this.doctorName, required this.id_booking});

  factory UnvailedBooking.fromJson(Map<String, dynamic> json) {
    return UnvailedBooking(
      id_booking: int.parse(json['id_clinicBook']),
      day: json['bookingDay'] as String,
      hour: int.parse(json['bookingHour']),
      date: json['bookinghistory'] as String,
      doctorName: json['doctor_name'] as String
    );
  }

}