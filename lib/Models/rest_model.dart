import 'dart:convert';

class RestaurantModel {
  final String name;
  final String image;
  final String location;
  RestaurantModel({
    required this.name,
    required this.image,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'location': location,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      name: map['name'],
      image: map['image'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source));
}
