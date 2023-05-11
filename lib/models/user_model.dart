class UserModel {
  late String role;
  late Details details;
  late DateTime createdAt;

  UserModel(
      {required this.role, required this.createdAt, required this.details});

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        // DateTime fromJson(Timestamp json['createdAt']) => value?.toDate();
        // createdAt: DateTime.now(),
        createdAt: json['createdAt'].toDate(),
        // convert timestamp to date in flutter?
        role: json['role'],
        details: Details(
          email: json['details']['email'],
          name: json['details']['name'],
          photoURL: json['details']['photoURL'],
          id: json['details']['id'],
        ),
      );
}

class Details {
  late String id;
  late String name;
  late String email;
  late String photoURL;

  Details({
    required this.id,
    required this.name,
    required this.email,
    required this.photoURL,
  });
}
