import 'package:flutter/material.dart';
import 'package:store/models/product.dart';
import 'package:store/screens/product_detail_screen.dart'; // importe bien ton écran de détail

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  final List<Product> products;

  const ProductListScreen({
    super.key,
    required this.categoryName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produits : $categoryName')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: product.images != null && product.images!.isNotEmpty
                ? Image.network(product.images!.first, width: 60, fit: BoxFit.cover)
                : const Icon(Icons.image_not_supported),
            title: Text(product.title ?? 'Sans titre'),
            subtitle: Text('\$${product.price?.toStringAsFixed(2) ?? ''}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
