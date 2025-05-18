import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:store/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? "Détails du produit")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrousel d'images
            if (product.images != null && product.images!.isNotEmpty)
              CarouselSlider(
                items: product.images!
                    .map((image) => Image.network(image.toString()))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
              ),
            // Ajoute ici d'autres widgets pour les détails du produit
          ],
        ),
      ),
    );
  }
}