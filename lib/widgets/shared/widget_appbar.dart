import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/screens/cart_screen.dart';
import 'package:store/screens/favorites_screen.dart';

class WidgetAppbar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'My Store',
        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),

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
        IconButton(
    icon: const Icon(Icons.shopping_cart),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      );
    },
  ),
        IconButton(
          icon: Icon(Icons.login),
          onPressed: () {
            context.replaceNamed('login');
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
