


class User {
  int id;
  String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id_user']),
      name: json['user_name'] as String,
    );
  }
}