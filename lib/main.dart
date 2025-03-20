import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/cart/cart_screen.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_accepted.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';
import 'package:inscri_ecommerce/screens/orders_history/orders_screen.dart';
import 'package:inscri_ecommerce/screens/register.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
//import 'package:inscri_ecommerce/screens/home/home_screen.dart';
//import 'package:inscri_ecommerce/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //kelmet debug tetnaha
      home: HomeScreen(), // Afficher directement la page d'inscription
    );
  }
}
