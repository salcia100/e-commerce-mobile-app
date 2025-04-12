import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/login.dart';
import 'package:inscri_ecommerce/screens/My_shop/my_shop_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
      home: Welcome(), // Afficher directement la page d'inscription
    );
  }
}
