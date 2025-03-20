import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';

class CheckoutAccepted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Check out',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 100), // Réduire le padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/checkout/checkout_ok.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover, // Ajuster l'image
            ),
            SizedBox(height: 20), // Espace après l'image
            Text(
              'Order Completed',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10), // Espace après le titre
            Text(
              'Thank you for your purchase.\nYou can view your order in ‘My Orders’ section.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30), // Espace avant le bouton
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDB3022),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                // Logic for Add to Cart action

                Navigator.push(
                  //push add tocart---->page checkout
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                'Continue shopping',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
