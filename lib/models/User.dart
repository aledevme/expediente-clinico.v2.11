import 'package:expediente_clinico/models/Enterprise.dart';

class User {
  String id;
  String email;
  String password;
  String role;
  String fullName;
  List<dynamic> enterprises;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.role,
      required this.fullName,
      required this.enterprises});

  factory User.fromJsonResponse(Map<String, dynamic> response) {
    return User(
        password: response['password'],
        id: response['_id'],
        fullName: '${response['name']} ${response['lastname']}',
        email: response['email'],
        role: response['role'],
        enterprises: response['enterprises']);
  }
}
