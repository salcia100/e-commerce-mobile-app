import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product/Product.dart';
import 'package:inscri_ecommerce/constant/home_constants.dart';

class itemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const itemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 180,
            width: 160,
            child: Image.network(
              //****.assets for images statiques --> .network() for api*/
              product.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported, size: 50);
              },
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
        )
      ],
    );
  }
}
