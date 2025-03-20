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
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Color(0xFF1D1F22),
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
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
