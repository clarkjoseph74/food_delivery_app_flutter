import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String image;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.address,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'address': address,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
