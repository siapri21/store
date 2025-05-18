import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/product.dart';
import 'package:store/providers/card_provider.dart';
import 'package:store/services/favorites_services.dart';
import 'favorites_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final FavoritesServices _favoritesServices = FavoritesServices();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final isFav = await _favoritesServices.isFavorite(widget.product.id!);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _addToFavorites() async {
    await _favoritesServices.addFavorite(widget.product.id!);
    setState(() {
      _isFavorite = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ajouté aux favoris")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
body: SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Liste défilante horizontale d'images
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: product.images?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.images![index],
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
      Text(product.title ?? '', style: const TextStyle(fontSize: 24)),
      const SizedBox(height: 8),
      Text('${product.price} €', style: const TextStyle(fontSize: 18)),
      const SizedBox(height: 16),
      Text(product.description ?? ''),
      const SizedBox(height: 20),
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: _isFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: _isFavorite ? null : _addToFavorites,
      ),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: () {
  Provider.of<CartProvider>(context, listen: false).addToCart(product);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Produit ajouté au panier")),
  );
},

        icon: const Icon(Icons.shopping_cart),
        label: const Text('Ajouter au panier'),
      ),
    ],
  ),
),


    );
  }
}
