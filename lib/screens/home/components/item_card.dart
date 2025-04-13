import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  final VoidCallback press;

  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isLiked = false;

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 180,
                width: 160,
                child: CachedNetworkImage(
                  imageUrl: widget
                      .product.image, // The image URL from your product model
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(), // Placeholder while loading
                  errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported,
                      size: 50), // Error handling
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 4),
                      child: Text(
                        widget.product.name,
                        style: TextStyle(color: kTextLightColor),
                      ),
                    ),
                    Text(
                      "\$${widget.product.price}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 8), 
                /*IconButton(
                  onPressed: toggleLike, // Handle the click here
                  icon: Icon(
                    isLiked
                        ? Icons.favorite
                        : Icons
                            .favorite_border, // Change the icon based on the state
                    color: kIconColor,
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
