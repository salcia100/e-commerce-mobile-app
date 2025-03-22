import 'package:flutter/material.dart';

// Cette fonction crée l'AppBar de votre page Wishlist
PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);  // Utilisation du contexte pour revenir à la page précédente
      },
    ),
    title: const Text(
      'Wishlist',
      style: TextStyle(
        color: Color(0xFF1D1F22),
        fontSize: 18,
        fontFamily: 'Product Sans',
      ),
    ),
    centerTitle: true,
  );
}
