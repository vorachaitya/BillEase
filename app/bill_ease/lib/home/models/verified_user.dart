class VerifiedUser {
  String? userType;
  String? phone;
  String? name;
  String? email;

  VerifiedUser({this.userType, this.phone, this.name, this.email});

  VerifiedUser.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
