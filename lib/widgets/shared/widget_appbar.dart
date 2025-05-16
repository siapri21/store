import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidgetAppbar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetAppbar({super.key});

  @override
  Widget build(BuildContext context) {
     return   AppBar(
        title: Text('My Store', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
     
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Handle search button press
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle shopping cart button press
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