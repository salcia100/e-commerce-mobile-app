import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class itemCard extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const itemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 180,
              width: 160,
              child: CachedNetworkImage(
                imageUrl:
                    product.image, // The image URL from your product model
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    CircularProgressIndicator(), // Placeholder while loading
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_not_supported, size: 50), // Error handling
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              product.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
