import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String size;
  final String color;
  final double price;
  final int quantity;
  final String imagePath;

  const CartItem({
    super.key,
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 10,
            )
          ],
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(250, 250, 250, 1),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            ClipRRect(                                                         //Image du produit
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(                                                        //Utilisation de Expanded pour empêcher l'overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1F22),
                    ),
                    overflow: TextOverflow.ellipsis,                       // pour éviter le dépassement
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Size: $size  |  Color: $color",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8A8A8F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1F22),
                    ),
                  ),
                ],
              ),
            ),

            Column(                                              // Boutons quantité et supprimer
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove, size: 16),
                    ),
                    Text(
                      "$quantity",
                      style: const TextStyle(fontSize: 14),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
