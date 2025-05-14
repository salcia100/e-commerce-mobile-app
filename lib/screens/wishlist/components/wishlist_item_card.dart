import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';

class WishlistItemCard extends StatefulWidget {
  final Product product;
  final VoidCallback onRemove; // Fonction pour supprimer le produit
  final VoidCallback press;

  const WishlistItemCard(
      {Key? key,
      required this.product,
      required this.onRemove,
      required this.press})
      : super(key: key);

  @override
  _WishlistItemCardState createState() => _WishlistItemCardState();
}

class _WishlistItemCardState extends State<WishlistItemCard> {
  bool isFavorite = true; // Produit en favori par défaut

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: GestureDetector(
          onTap: widget.press,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image + Icône Cœur
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: 160,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.image, // The image URL from your product model
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(), // Placeholder while loading
                      errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          size: 50), // Error handling
                    ),
                  ),

                  // Icône pour supprimer de la wishlist
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        if (!isFavorite) {
                          widget
                              .onRemove(); // Supprime le produit de la wishlist
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Détails du produit
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom du produit
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Prix et Stock
                    Row(
                      children: [
                        Text(
                          "\$${widget.product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        if (widget.product.stock ==
                            0) // Produit en rupture de stock
                          const Text(
                            "Out of stock",
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
