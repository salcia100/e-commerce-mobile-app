import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'wishlist_item_card.dart';

class WishlistBody extends StatefulWidget {

  

  const WishlistBody({Key? key}) : super(key: key);

  @override
  _WishlistBodyState createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
    List<Product> wishlist = [];
   final WishListApi apiService = WishListApi();
  List<dynamic> products = [];
  bool isLoading = true; // Pour afficher un indicateur de chargement



  

  void removeFromWishlist(Product product) async {
    try {
      await WishListApi.removeLike(product.id);
      setState(() {
        wishlist.removeWhere((item) => item.id == product.id);
      });
    } catch (e) {
      print("Erreur lors de la suppression : $e");
    }
  }

  @override
Widget build(BuildContext context) {
  print(products); // 🔍 Vérifier le contenu de la liste
  
  return products.isEmpty
      ? Center(child: Text("Wishlist is Empty 😢"))
      : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product? item = products[index]; 
            if (item == null) {
              return SizedBox.shrink(); // Évite d'afficher un produit null
            }
            return WishlistItemCard(
              product: Product(
                id: item.id,
                name: item.name ?? "Produit inconnu",
                price: item.price ?? 0.0,
                description: item.description ?? "Pas de description",
                image: item.image ?? "assets/images/default_image.jpg",
                stock: item.stock ?? 0,
                reviews: item.reviews ?? [],
              ), 
              onRemove: () {},
            );
          },
        );
}
}






/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
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
   final WishListApi apiService = WishListApi();
  List<dynamic> products = [];
  bool isLoading = true;

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
     return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product item = products[index];
                return Card(
                  product: Product(
                    id: item.id,
                      name: item.name,
                      price: item.price,
                      description: item.description,
                     image: item.image,
                      stock: item.stock,
                      reviews: item.reviews),
                  /* title: item.name,
                    size: "S",
                    color: "Beige",
                    price: item.price,
                    quantity: item.quantity,
                    imagePath: item.image,*/
                );
              },
            ),
          ),
        ]
     ),
     );

  }*/





   /* return wishlist.isEmpty
        ? const Center(
            child: Text(
              "Your wishlist is empty 😢",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                return WishlistItemCard(
                  product: wishlist[index],
                  onRemove: () => removeFromWishlist(wishlist[index]),
                 
                );
              },
            ),
          );
  }*/

