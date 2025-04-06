import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/edit_product/edit_product_screen.dart';

class MyShopBody extends StatelessWidget {
  // Liste temporaire des produits
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/wishlist/1.jpg",
      "name": "robe1",
      "price": "40 DT",
      "likes": 12,
      "discount": 0,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/2.jpg",
      "name": "robe2",
      "price": "33 DT",
      "likes": 11,
      "discount": 0,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/9.jpg",
      "name": "robe3",
      "price": "25 DT",
      "likes": 15,
      "discount": 29,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/10.jpg",
      "name": "robe4",
      "price": "30 DT",
      "likes": 16,
      "discount": 25,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/8.jpg",
      "name": "robe5",
      "price": "50 DT",
      "likes": 20,
      "discount": 15,
      "created_at": "null"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 colonnes
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7, // Ajustement du ratio
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image produit avec overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  product["image"],
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount badge
              if (product["discount"] > 0)
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "-${product["discount"]}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Menu contextuel (3 points) en haut à droite
              Positioned(
                top: 5,
                right: 5,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Update',style: TextStyle(color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                  onSelected: (String value) {
                    switch (value) {
                      case 'Edit':
                        // Naviguer vers la page EditProductScreen avec les données du produit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(),
                          ),
                        );
                        break;
                      case 'Delete':
                        // Action suppression à ajouter ici
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(),
                          ),
                        );
                        break;
                    }
                  },
                ),
              ),
            ],
          ),

          // Détails du produit
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom du produit
                Text(
                  product["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                // Prix et likes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product["price"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kIconColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        const Icon(Icons.favorite_border, 
                            color: Colors.grey, size: 18),
                        const SizedBox(width: 4),
                        Text("${product["likes"]}"),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                // Date d'ajout
                Text(
                  "Ajouté le ${product["created_at"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/edit_product/edit_product_screen.dart';

class MyShopBody extends StatelessWidget {
  // Liste temporaire des produits
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/wishlist/1.jpg",
      "name": "robe1",
      "price": "40 DT",
      "likes": 12,
      "discount": 0,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/2.jpg",
      "name": "robe2",
      "price": "33 DT",
      "likes": 11,
      "discount": 0,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/9.jpg",
      "name": "robe3",
      "price": "25 DT",
      "likes": 15,
      "discount": 29,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/10.jpg",
      "name": "robe4",
      "price": "30 DT",
      "likes": 16,
      "discount": 25,
      "created_at": "null"
    },
    {
      "image": "assets/wishlist/8.jpg",
      "name": "robe5",
      "price": "50 DT",
      "likes": 20,
      "discount": 15,
      "created_at": "null"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 colonnes
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7, // Ajustement du ratio
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image produit avec overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  product["image"],
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Discount badge
              if (product["discount"] > 0)
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "-${product["discount"]}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Menu contextuel (3 points) en haut à droite
              Positioned(
                top: 5,
                right: 5,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Modifier',style: TextStyle(color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Supprimer', style: TextStyle(color: Colors.black)),
                    ),
                   
                  ],
                  onSelected: (String value) {
                    switch (value) {
                      case 'Edit':
                        Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProductScreen(product: products),
                    ),
                  );
                        break;
                      case 'Delete':
                        // Action suppression
                        break;
                    }
                  },
                ),
              ),
            ],
          ),

          // Détails du produit
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom du produit
                Text(
                  product["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                // Prix et likes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product["price"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kIconColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        const Icon(Icons.favorite_border, 
                            color: Colors.grey, size: 18),
                        const SizedBox(width: 4),
                        Text("${product["likes"]}"),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                // Date d'ajout
                Text(
                  "Ajouté le ${product["created_at"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/





/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';

class MyShopBody extends StatelessWidget {
  // Liste temporaire des produits
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/wishlist/1.jpg",
      "name": "robe1",
      "price": "40 DT",
      "likes": 12,
      "discount": 0
    },
    {
      "image": "assets/wishlist/2.jpg",
      "name": "robe2",
      "price": "33 DT",
      "likes": 11,
      "discount": 0
    },
    {
      "image": "assets/wishlist/9.jpg",
      "name": "robe3",
      "price": "25 DT",
      "likes": 15,
      "discount": 29
    },
    {
      "image": "assets/wishlist/10.jpg",
      "name": "robe4",
      "price": "30 DT",
      "likes": 16,
      "discount": 25
    },
    {
      "image": "assets/wishlist/8.jpg",
      "name": "robe5",
      "price": "50 DT",
      "likes": 20,
      "discount": 15
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 colonnes
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7, // Ajustement du ratio
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

// Widget pour une carte produit
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image produit
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  product["image"],
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (product["discount"] >
                  0) // Affichage du discount si disponible
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "-${product["discount"]}%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),


           // 👇 Icône flèche avec menu contextuel en haut à droite
              Positioned(
                top: 5,
                right: 5,
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Edit') {
                      // Action pour éditer le produit
                      print("Éditer le produit");
                    } else if (value == 'Delete') {
                      // Action pour supprimer le produit
                      print("Supprimer le produit");
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'Edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.black),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ];
                  },
                  icon: Icon(Icons.more_horiz), // Icône de flèche
                ),
              ),
            
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 📌 Nom du produit
                    Expanded(
                      child: Text(
                        product["name"],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // ❤️ Nombre de likes
                    Row(
                      children: [
                        Icon(Icons.favorite_border,
                            color: Colors.grey, size: 18),
                        SizedBox(width: 5),
                        Text("${product["likes"]}",
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                Text(
                  product["price"],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kIconColor),
                ),
                Text(
                  "Ajouté le ${product["created_at"]}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
