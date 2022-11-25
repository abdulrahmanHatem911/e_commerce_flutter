import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  int id;
  String name;
  String description;
  String imageUrl;
  double price;
  int categoryId;
  Category? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageURL"],
        price: json["price"].toDouble(),
        categoryId: json["categoryId"].toInt(),
        category: Category.fromJson(json["category"]),
      );
  //tomap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageURL': imageUrl,
      'price': price.toInt(),
      'categoryId': categoryId,
    };
  }

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
