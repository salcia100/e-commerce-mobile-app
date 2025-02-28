import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/home.dart';
import 'package:inscri_ecommerce/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
      /* title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),*/
      home: HomeScreen(), // Afficher directement la page d'inscription
    );
  }
}
