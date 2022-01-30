
class Lab{
  int id;
  String labName;


  Lab({required this.id,required this.labName});

  factory Lab.fromJson(Map<String, dynamic> json){
    return Lab(
      id: int.parse(json['id_lab']),
      labName: json['lab_name'],
    );
  }
}