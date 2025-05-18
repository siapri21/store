// main
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/router_service.dart';
import 'package:store/theme/app_theme.dart';
import 'package:store/providers/product_provider.dart';


  // ajout des providers
 void main() => runApp(
  MultiProvider( // Un SEUL MultiProvider
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
    ],
    child: const MyStore(), // const ajouté si possible
  ),
);


// widget (classe) de l'application
class MyStore extends StatelessWidget {
  // constructeur
  const MyStore({super.key});

  // build permet d'afficher l'interface
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "My Store",
      theme: AppTheme().getTheme(),
      // utiliser le routeur
      routerConfig: RouterService().getRouter(),

      // home: RootLayout(screen: HomeScreen()),
    );
  }
}

  

