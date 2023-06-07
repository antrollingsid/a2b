import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String role;
  late Details details;
  late DateTime createdAt;

  UserModel(
      {required this.role, required this.createdAt, required this.details});
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        // DateTime (Timestamp json['createdAt']) => value?.toDate();

        // createdAt: Timestamp.fromDate(json['createdAt'] as DateTime),
        createdAt: json['createdAt'].toDate() ?? DateTime.now(),
        role: json['role'],
        details: Details(
          email: json['details']['email'],
          name: json['details']['name'],
          surname: json['details']['surname'],
          photoURL: json['details']['photoURL'],
          id: json['details']['id'],
          phone: json['details']['phoneNumber'],
        ),
      );
}

class Details {
  late String id;
  late String name;
  late String phone;
  late String surname;
  late String email;
  late String photoURL;

  Details({
    required this.id,
    required this.name,
    required this.phone,
    required this.surname,
    required this.email,
    required this.photoURL,
  });
}
