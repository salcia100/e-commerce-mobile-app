import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'categories.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final  List<dynamic> products;
  final  List<Category> categories;
  final Function(int) onCategorySelected; // Add this callback


  Body({required this.onRefresh,required this.products,required this.categories,required this.onCategorySelected});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  
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
        
        Categories(categories:widget.categories,onCategorySelected: widget.onCategorySelected),

        Expanded(
          child: RefreshIndicator(
            onRefresh: widget.onRefresh, // Trigger _onRefresh when pulled
            child: GridView.builder(
              itemCount: widget.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: widget.products[index],
                press: () {
                  print("Tapped on ${widget.products[index].name}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: widget.products[index],
                        ),
                      ));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
