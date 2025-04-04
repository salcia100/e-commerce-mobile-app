import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/Login.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
      home: SignInPage(), // Afficher directement la page d'inscription
    );
  }
}
