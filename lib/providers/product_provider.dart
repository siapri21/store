import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store/models/product.dart';
import 'dart:convert'; // Pour json.decode

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  // Récupère les produits par catégorie
  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('https://lakeapi.platzi.com/products?categoryId=$categoryId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).toList();
        notifyListeners(); // Met à jour les écrans qui écoutent ce provider
      }
    } catch (e) {
      debugPrint("Erreur API: $e");
    }
  }

  // Récupère un produit par son ID
  Future<Product?> fetchProductById(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('https://lakeapi.platzi.com/products/$productId'),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      }
    } catch (e) {
      debugPrint("Erreur API: $e");
    }
    return null;
  }
}