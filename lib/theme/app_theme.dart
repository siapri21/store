import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 230, 103, 219),),
        textTheme:  TextTheme( 
          headlineMedium: TextStyle(fontFamily: 'Arvo', fontWeight: FontWeight.bold, fontSize: 25),
          bodyMedium: TextStyle(fontFamily: 'Arvo')),
    );
  }
}