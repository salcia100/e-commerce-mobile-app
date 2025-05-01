import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'wishlist_item_card.dart';

class WishlistBody extends StatelessWidget {
  final List<Product> likedproducts;
  final Future<void> Function() onRefresh;

  const WishlistBody(
      {Key? key, required this.likedproducts, required this.onRefresh})
      : super(key: key);

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
        ? Center(child: Text("Wishlist is Empty "))
        : RefreshIndicator(
            onRefresh: onRefresh, // Ajout du RefreshIndicator ici
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(), // Important
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: likedproducts.length,
              itemBuilder: (context, index) {
                return WishlistItemCard(
                  product: likedproducts[index],
                  onRemove: () {
                    removeFromWishlist(likedproducts[index]);
                  },
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: likedproducts[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
  }
}
