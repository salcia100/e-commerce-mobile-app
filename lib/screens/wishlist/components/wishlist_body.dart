import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';

import 'wishlist_item_card.dart';

class WishlistBody extends StatefulWidget {
  final List<Product> wishlistItems;

  const WishlistBody({Key? key, required this.wishlistItems}) : super(key: key);

  @override
  _WishlistBodyState createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  List<Product> wishlist = [];

  @override
  void initState() {
    super.initState();
    wishlist = widget.wishlistItems;
  }

  void removeFromWishlist(Product product) {
    setState(() {
      wishlist.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wishlist.isEmpty
        ? const Center(
            child: Text(
              "Your wishlist is empty 😢",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return WishlistItemCard(
                  product: wishlist[index],
                  onRemove: () => removeFromWishlist(wishlist[index]),
                );
              },
            ),
          );
  }
}
