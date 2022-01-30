

class AppointmentHour {
  int availableHour;

  AppointmentHour({required this.availableHour});

  factory AppointmentHour.fromJson(Map<String, dynamic> json) {
    return AppointmentHour(
      availableHour: int.parse(json['availableHour']),
    );
  }

}