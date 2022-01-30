

class Appointment {
  String availableDay;

  Appointment({required this.availableDay});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      availableDay: json['availableDay'] as String,
    );
  }

}