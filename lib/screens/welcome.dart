import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/home/home_screen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image d'arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/wishlist/8.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay semi-transparent
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Texte de bienvenue
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to My Store!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Product Sans',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  'The home for a fashionista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Product Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          // Bouton "Get Started"
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.white, width: 1.2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Product Sans',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
