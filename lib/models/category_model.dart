class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  int id;
  String name;
  String imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageURL": imageUrl,
      };
}
