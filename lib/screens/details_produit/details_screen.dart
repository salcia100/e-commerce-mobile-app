import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/details_produit/components/body.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbarColor,
        title: const Text("Product Details"),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kIconColor,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          navIcon(0, Icons.search, Icons.search_outlined),
          navIcon(1, Icons.shopping_cart, Icons.shopping_cart_outlined),
          navIcon(2, Icons.person, Icons.person_outline),
          SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: Body(product: widget.product),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget navIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return IconButton(
      icon: Icon(
        selectedIndex == index ? filledIcon : outlinedIcon,
        color: selectedIndex == index
            ? kIconColor
            : kIconColor, // Change la couleur en fonction de l'index sélectionné
        size: 25,
      ),
      onPressed: () {
        setState(() {
          selectedIndex =
              index; // Change l'index sélectionné et met à jour l'état
        });
      },
    );
  }
}
