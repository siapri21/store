// import 'package:store/models/category.dart';

// class Product {
//   int? id;
//   num? price;
//   String? title, slug, description;
//   Category category;
//   List<dynamic>? images;

//   Product({
//     required this.id,
//     required this.title,
//     required this.slug,
//     required this.price,
//     required this.description,
//     required this.category,
//     required this.images,
//   });
// }
import 'package:store/models/category.dart';

class Product {
  int? id;
  num? price;
  String? title, slug, description;
  Category category;
  List<dynamic>? images;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  // Ajoute cette méthode pour parser les données de l'API
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: json['price'],
      description: json['description'],
      category: Category.fromJson(json['category']), // Supposant que Category a fromJson
      images: json['images'] ?? [], // Si 'images' peut être null
    );
  }
}