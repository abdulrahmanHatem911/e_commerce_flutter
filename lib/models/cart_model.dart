import 'package:flutter/material.dart';

class CartModel {
  final int id;
  final String productId;
  final String name;
  final String description;
  final String image;
  final double price;
  final ValueNotifier<int>? quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.quantity,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        productId: json["productId"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: double.parse(json["price"].toString()),
        quantity: ValueNotifier(json['quantity']),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity?.value,
    };
  }
}
