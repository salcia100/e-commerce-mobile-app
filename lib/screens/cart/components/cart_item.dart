import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inscri_ecommerce/api/Cart_api.dart';
import 'package:inscri_ecommerce/model/Cart.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final Function removeItem; // Callback function to remove the item
  final Function(int id, int newQuantity) updateQuantity; // Add callback

  CartItem({required this.cart, required this.removeItem,required this.updateQuantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              offset: Offset(0, 4),
              blurRadius: 10,
            )
          ],
          color: Theme.of(context).cardColor,//color: Colors.white,
          border: Border.all(
            color: Theme.of(context).dividerColor,//color: const Color.fromRGBO(250, 250, 250, 1),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              //Image du produit
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: cart.imagePath, // Use the imagePath from the model
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.image_not_supported, size: 50)),

                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1F22),
                    ),
                    overflow:
                        TextOverflow.ellipsis, // pour éviter le dépassement
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Size:" + cart.size + "|" + " Color:" + cart.color,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8A8A8F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${cart.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1F22),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                // Boutons quantité et supprimer
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (cart.quantity > 1) {
                            int newQuantity = cart.quantity - 1;
                            updateQuantity(cart.id, newQuantity);
                            await CartApi.decrementquantity(cart.id);
                          }
                        },
                        icon: const Icon(Icons.remove, size: 16),
                      ),
                      Text(
                        cart.quantity.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () async {
                          int newQuantity = cart.quantity + 1;
                          updateQuantity(cart.id, newQuantity);
                          await CartApi.incrementquantity(cart.id);
                        },
                        icon: const Icon(Icons.add, size: 16),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      int id = cart.id;
              
                      await CartApi.RemoveProductFomCart(id);
                      removeItem(id); // Call the callback function to remove the item from the list
                      print("product deleted from cart ");
                    },
                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
