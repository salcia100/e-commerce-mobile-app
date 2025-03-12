import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_item.dart';
import 'package:inscri_ecommerce/screens/cart/components/cart_resume.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Color(0xFF1D1F22),
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Liste des articles
            CartItem(
              title: "Coat",
              size: "S",
              color: "Beige",
              price: 30.00,
              quantity: 1,
              imagePath: "assets/cart/10.jpg",
            ),
            CartItem(
              title: "Sweater",
              size: "M",
              color: "brown",
              price: 39.99,
              quantity: 1,
              imagePath: "assets/cart/11.jpg",
            ),
             
            CartItem(
              title: "Dress",
              size: "M",
              color: "Beige",
              price: 39.99,
              quantity: 1,
              imagePath: "assets/cart/12.jpg",
            ),

            const SizedBox(height: 20),

            // Résumé du panier
            const CartSummary(subtotal: 110.00),
          ],
        ),
      ),
    );
  }
}
