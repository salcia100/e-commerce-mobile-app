import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/home_constants.dart';
import 'categories.dart';
import 'package:inscri_ecommerce/model/Product/Product.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            "Women",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 54, 32, 35)),
          ),
        ),
        Categories(),
        Expanded(
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPadding,
              crossAxisSpacing: kDefaultPadding,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => itemCard(
              product: products[index],
              press: () {
                print("Tapped on ${products[index].name}");
              },
            ),
          ),
        ),
      ],
    );
  }
}
