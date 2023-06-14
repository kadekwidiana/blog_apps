// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  String title;
  String category;
  String image;
  String location;
  String jam_buka;
  String rating;
  String description;
  // DateTime createdAt;
  // DateTime updatedAt;

  Post({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.location,
    required this.jam_buka,
    required this.rating,
    required this.description,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        image: json["image"],
        location: json["location"],
        jam_buka: json["jam_buka"],
        rating: json["rating"],
        description: json["description"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "image": image,
        "location": location,
        "jam_buka": jam_buka,
        "rating": rating,
        "description": description,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
