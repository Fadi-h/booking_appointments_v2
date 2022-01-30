class Doctor {
  int id;
  String name;
  String clinic;

  Doctor({required this.id, required this.name, required this.clinic});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: int.parse(json['id_doctor']),
      name: json['doctor_name'] as String,
      clinic: json['clinic_name'] as String,
    );
  }
}