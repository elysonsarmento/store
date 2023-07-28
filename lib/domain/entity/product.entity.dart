abstract interface class Product {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String image;
  double rating;
  double totalRating;
  bool? isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.totalRating,
    this.isFavorite = false,
  });

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    Category? category,
    String? image,
    double? rating,
    double? totalRating,
    bool? isFavorite,
  });

  Map<String, dynamic> toMap();
  Product fromMap(Map<String, dynamic> map);

  @override
  String toString() {
    return 'Product(id: $id, isFavorite: $isFavorite ,title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating, totalRating: $totalRating)';
  }

  String toJson();

  Product fromJson(String source);
}

enum Category { electronics, jewelery, menClothing, womenClothing }

extension CategoryExtension on Category {
  String get displayName {
    switch (this) {
      case Category.electronics:
        return 'electronics';
      case Category.jewelery:
        return 'jewelery';
      case Category.menClothing:
        return 'men\'s clothing';
      case Category.womenClothing:
        return 'women\'s clothing';
    }
  }

  static Category fromString(String value) {
    switch (value) {
      case 'electronics':
        return Category.electronics;
      case 'jewelery':
        return Category.jewelery;
      case 'men\'s clothing':
        return Category.menClothing;
      case 'women\'s clothing':
        return Category.womenClothing;
      default:
        throw Exception('Invalid category');
    }
  }
}
