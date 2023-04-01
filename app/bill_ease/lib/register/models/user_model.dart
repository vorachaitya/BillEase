class UserModel {
  String name;
  String email;
  String phone;

  UserModel({required this.email, required this.name, required this.phone});

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "phone": phone};
  }
}
