class CategoryModel {
  int id;
  String name;
  String imageUrl;
  bool isActive;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isActive,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageURL"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageURL": imageUrl,
        "isActive": isActive,
      };
}
