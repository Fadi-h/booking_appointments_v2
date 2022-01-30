

class Booking{
  int bookingHour;
  String doctorName;
  int idClinicBook;

  Booking({required this.bookingHour, required this.doctorName, required this.idClinicBook});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingHour: int.parse(json['bookingHour']),
      doctorName: json['doctor_name'] as String,
        idClinicBook: int.parse(json['id_clinicBook'])
    );
  }

}