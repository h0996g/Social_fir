class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isVir;
  UserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.uId,
      required this.isVir});
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    uId = json['uId'];
    isVir = json['isVir'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isVir': isVir
    };
  }
}
