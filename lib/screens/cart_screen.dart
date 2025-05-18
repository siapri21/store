import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/card_provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
      ),
      body: items.isEmpty
          ? const Center(child: Text("Votre panier est vide."))
          :
         ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final cartItem = items[index];
    final product = cartItem.product;

    return ListTile(
      leading: product.images?.isNotEmpty == true
          ? Image.network(product.images!.first, width: 50)
          : null,
      title: Text(product.title ?? ''),
      subtitle: Text('${product.price} €'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              cart.decreaseQuantity(product);
            },
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              cart.increaseQuantity(product);
            },
          ),
        ],
      ),
    );
  },
),

     bottomNavigationBar: items.isNotEmpty
    ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: ${cart.totalPrice.toStringAsFixed(2)} €',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Commande passée !")),
                );
              },
              child: const Text("Passer la commande"),
            ),
          ],
        ),
      )


          : null,
    );
  }
}
