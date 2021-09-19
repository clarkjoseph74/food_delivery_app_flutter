import 'dart:convert';

class ProductModel {
  final String name;
  final String restName;
  final String image;
  final int price;
  final String des;
  ProductModel({
    required this.name,
    required this.restName,
    required this.image,
    required this.price,
    required this.des,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'restName': restName,
      'image': image,
      'price': price,
      'des': des,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      restName: map['restName'],
      image: map['image'],
      price: map['price'],
      des: map['des'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
