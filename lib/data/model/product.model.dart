import 'dart:convert';

import 'package:store/domain/entity/product.entity.dart';

class ProductModel implements Product {
  @override
  Category category;

  @override
  String description;

  @override
  int id;

  @override
  String image;

  @override
  double price;

  @override
  double rating;

  @override
  String title;

  @override
  double totalRating;

  @override
  bool? isFavorite;
  ProductModel({
    required this.category,
    required this.description,
    required this.id,
    required this.image,
    required this.price,
    required this.rating,
    required this.title,
    required this.totalRating,
    this.isFavorite = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'category': category.displayName,
      'description': description,
      'id': id,
      'image': image,
      'price': price,
      'rating': {
        'rate': rating,
        'count': totalRating,
      },
      'title': title,
      'isFavorite': isFavorite,
    };
  }

  @override
  Product copyWith({
    Category? category,
    String? description,
    int? id,
    String? image,
    double? price,
    double? rating,
    String? title,
    double? totalRating,
    bool? isFavorite,
  }) {
    return ProductModel(
      category: category ?? this.category,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      totalRating: totalRating ?? this.totalRating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      category: CategoryExtension.fromString(map['category'] ?? ''),
      description: map['description'] ?? '',
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']["rate"]?.toDouble() ?? 0.0,
      title: map['title'] ?? '',
      totalRating: map['rating']["count"]?.toDouble() ?? 0.0,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Product fromJson(String source) => ProductModel.fromMap(json.decode(source));

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(category: $category, isFavorite: $isFavorite,description: $description, id: $id, image: $image, price: $price, rating: $rating, title: $title, totalRating: $totalRating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.category == category &&
        other.description == description &&
        other.id == id &&
        other.image == image &&
        other.price == price &&
        other.rating == rating &&
        other.title == title &&
        other.totalRating == totalRating;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        description.hashCode ^
        id.hashCode ^
        image.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        title.hashCode ^
        totalRating.hashCode;
  }

  @override
  Product fromMap(Map<String, dynamic> map) {
    return ProductModel.fromMap(map);
  }
}
