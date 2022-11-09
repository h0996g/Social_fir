class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isVir;
  String? img;
  String? bio;
  String? cover;
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isVir,
    required this.img,
    required this.bio,
    required this.cover,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    uId = json['uId'];
    isVir = json['isVir'];
    img = json['img'];
    bio = json['bio'];
    cover = json['cover'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isVir': isVir,
      'img': img,
      'bio': bio,
      'cover': cover,
    };
  }
}
