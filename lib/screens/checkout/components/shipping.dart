import 'package:flutter/material.dart';

class ShippingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section pour le texte "Check out" avec une icône de retour
          /*Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Retourne à la page précédente
                },
              ),
              SizedBox(width: 8), // Un peu d'espace entre l'icône et le texte
              Text(
                'Check out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),*/
          SizedBox(height: 20),

          
          
          // Texte "Step 1" et "Shipping"
          Text(
            'Step 1',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Text(
            'Shipping',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          
          // Champs de saisie pour l'adresse de livraison
          TextField(
            decoration: InputDecoration(
              labelText: 'Home*',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Address*',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Phone*',
            ),
          ),
        ],
      ),
    );
  }
}
