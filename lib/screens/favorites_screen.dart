import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store/models/product.dart';
import 'package:store/services/favorites_services.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesServices _favoritesServices = FavoritesServices();
  List<Product> favorites = [];
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }
// Future<List<Product>> fetchProductsFromApi() async {
//   final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//     return data.map<Product>((json) => Product.fromJson(json)).toList(); // 👈 Note ici
//   } else {
//     throw Exception('Erreur de chargement des produits');
//   }
// }



  Future<void> _loadFavorites() async {
    final ids = await _favoritesServices.getFavorites(); // List<int>
    print("🟢 IDs favoris : $ids");

    // try {
    //   final allProducts = await fetchProductsFromApi();
    //   final favs = allProducts.where((product) => ids.contains(product.id)).toList();

    //   setState(() {
    //     favorites = favs;
    //     _isFetching = false;
    //     print("🟡 Produits trouvés : ${favorites.map((e) => e.title).toList()}");
    //   });
    // } catch (e) {
    //   print('Erreur API : $e');
    //   setState(() {
    //     _isFetching = false;
    //   });
    // }
  }

  Future<void> _removeFavorite(Product product) async {
    await _favoritesServices.removeFavorite(product.id!);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: _isFetching
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? const Center(child: Text('Aucun produit favori'))
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return ListTile(
                      leading: product.images != null && product.images!.isNotEmpty
                          ? Image.network(
                              product.images!.first,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image);
                              },
                            )
                          : const Icon(Icons.image_not_supported),
                      title: Text(product.title ?? ''),
                      subtitle: Text('${product.price} €'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeFavorite(product),
                      ),
                    );
                  },
                ),
    );
  }
}
