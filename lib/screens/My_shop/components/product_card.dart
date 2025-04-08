import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Product_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/My_shop/delete_product_confirmation.dart';
import 'package:inscri_ecommerce/screens/My_shop/edit_product_modal.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Future<void> Function() onRefresh;

  const ProductCard({required this.product, required this.onRefresh, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductApi productApi = new ProductApi();
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: product.image, // Image URL from API
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
                ),
              ),
              /*
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
                ),*/

              // Menu contextuel (3 points) en haut à droite
              Positioned(
                top: 5,
                right: 5,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child:
                          Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child:
                          Text('Delete', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                  onSelected: (String value) {
                    switch (value) {
                      case 'Edit':
                        showEditProductModal(context, product.id, product,onRefresh);
                        break;
                      case 'Delete':
                        DeleteProductConfirmation.showDeleteDialog(
                          context: context,
                          onConfirm: () async {
                            try {
                              await productApi.deleteProduct(product.id);
                              successToast("Product deleted successfully!");
                              onRefresh();
                            } catch (e) {
                              errorToast("Error while deleting !");
                            }
                          },
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
                  product.name,
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
                      '${product.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kIconColor,
                      ),
                    ),
                    /*
                    Row(
                      children: [
                        const Icon(Icons.favorite_border, 
                            color: Colors.grey, size: 18),
                        const SizedBox(width: 4),
                        Text("${product["likes"]}"),
                      ],
                    ),*/
                  ],
                ),

                const SizedBox(height: 4),

                // Date d'ajout
                Text(
                  "Ajouté le ${product.date}",
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
