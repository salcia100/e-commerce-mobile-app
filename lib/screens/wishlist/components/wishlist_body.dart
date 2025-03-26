import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'wishlist_item_card.dart';

class WishlistBody extends StatelessWidget {
  final List<Product> likedproducts;
  final VoidCallback onRefresh;

  const WishlistBody({Key? key, required this.likedproducts, required this.onRefresh}) : super(key: key);

  // Remove the product from wishlist
  void removeFromWishlist(Product product) async {
    try {
      await WishListApi.removeLike(product.id);
      onRefresh(); // Trigger parent to refresh the wishlist
    } catch (e) {
      print("Erreur lors de la suppression : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return likedproducts.isEmpty
        ? Center(child: Text("Wishlist is Empty 😢"))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
              childAspectRatio: 0.75, // Controls width and height of each item
            ),
            itemCount: likedproducts.length,
            itemBuilder: (context, index) {
              return WishlistItemCard(
                product: likedproducts[index],
                onRemove: () {
                  removeFromWishlist(likedproducts[index]); // Handle remove
                },
              );
            },
          );
  }
}
