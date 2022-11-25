import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.categoryId,
    this.category,
  });

  int? id;
  String? name;
  String? description;
  String? imageUrl;
  double? price;
  int? categoryId;
  Category? category;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageURL"],
        price: json["price"].toDouble(),
        categoryId: json["categoryId"].toInt(),
        category: Category.fromJson(json["category"]),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        categoryId,
        category,
      ];
}

class Category extends Equatable {
  Category({
    this.id,
    this.name,
    this.imageUrl,
  });

  int? id;
  String? name;
  String? imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"].toInt(),
        name: json["name"],
        imageUrl: json["imageURL"],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];
}
