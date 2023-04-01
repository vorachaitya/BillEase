// ignore_for_file: non_constant_identifier_names

class UserModel {
  String name;
  String email;
  String phone;
  String user_type;

  UserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.user_type});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "user_type": user_type
    };
  }
}
