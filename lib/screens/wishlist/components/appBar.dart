import 'package:flutter/material.dart';

// Cette fonction crée l'AppBar de votre page Wishlist
PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
      onPressed: () {
        Navigator.pop(context);  // Utilisation du contexte pour revenir à la page précédente
      },
    ),
    title: Text(
      'Wishlist',
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge?.color,
        fontSize: 18,
        fontFamily: 'Product Sans',
      ),
    ),
    centerTitle: true,
  );
}
