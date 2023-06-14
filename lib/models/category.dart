// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  String categoryName;
  // dynamic createdAt;
  // dynamic updatedAt;

  Category({
    required this.id,
    required this.categoryName,
    // this.createdAt,
    // this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        // createdAt: json["created_at"],
        // updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        // "created_at": createdAt,
        // "updated_at": updatedAt,
      };
}
