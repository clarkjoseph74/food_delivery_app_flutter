import 'dart:convert';

class CartElement {
  String name;
  String image;
  int price;
  int quantity;
  CartElement({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartElement.fromMap(Map<dynamic, dynamic> map) {
    return CartElement(
      name: map['name'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartElement.fromJson(String source) =>
      CartElement.fromMap(json.decode(source));
}
