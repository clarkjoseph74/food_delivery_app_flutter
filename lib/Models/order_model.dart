import 'dart:convert';

import 'package:food_delivery_app/Models/cart_el_model.dart';

class OrderModel {
  List<CartElement> foodOrder;
  String name;
  String location;
  String totalPrice;
  OrderModel({
    required this.foodOrder,
    required this.name,
    required this.location,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodOrder': foodOrder.map((x) => x.toMap()).toList(),
      'name': name,
      'location': location,
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      foodOrder: List<CartElement>.from(
          map['foodOrder']?.map((x) => CartElement.fromMap(x))),
      name: map['name'],
      location: map['location'],
      totalPrice: map['totalPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
