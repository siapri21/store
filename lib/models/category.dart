// class Category {
//   // propriétés
//   // ? null
//   int? id;
//   String? name, slug, image;

//   // constructeur avec paramètres promus obligatoires
//   Category({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.image,
//   });
// }
class Category {
  final int id;
  final String name;
  final String? image; // Optionnel si présent dans l'API

  Category({
    required this.id,
    required this.name,
    this.image,
  });

  // Ajoute cette méthode factory
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'], // Optionnel
    );
  }
}
