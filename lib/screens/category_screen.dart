import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category.dart';
import 'package:store/models/product.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/category_api_service.dart';
import 'package:store/screens/product_detail_screen.dart'; // Nouvel import

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère la catégorie depuis le Provider
    Category category = context.watch<CategoryProvider>().category!;

    return Scaffold( // Ajouté pour la cohérence de navigation
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              category.name!,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            // Liste des produits
            Expanded( // Permet à la ListView de prendre tout l'espace disponible
              child: FutureBuilder(
                future: CategoryApiService().getProductsByCategoryId(category.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Erreur de chargement"));
                  }
                  if (snapshot.hasData) {
                    List<Product> products = snapshot.requireData;
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return Card( // Améliore l'UI avec des Cartes
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: product.images?.isNotEmpty == true
                                ? Image.network(
                                    product.images![0],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image_not_supported),
                            title: Text(product.title ?? "Sans titre"),
                            subtitle: Text("${product.price?.toStringAsFixed(2)}€"),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigation vers l'écran de détails
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(product: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Aucun produit trouvé"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}