import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/filter_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/category_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/discount_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/color_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/price_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/rating_filter.dart';

class FilterSidebar extends StatefulWidget {
  final Function(List<Product>) onFilteredResults;

  FilterSidebar({required this.onFilteredResults});
  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<FilterSidebar> {
  double minPrice = 0; //####123456
  double maxPrice = 200;
  List<String> selectedColors = [];
  int rating = 0;
  int selectedCategory = 0;
  List<String> discounts = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Icon(
                Icons.tune,
                size: 28,
              )
            ],
          ),
          //simple ligne
          Divider(height: 50),
          //price
          Text("Price",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          PriceFilter(
            onpriceSelected: (min, max) {
              setState(() {
                minPrice = min;
                maxPrice = max;
              });
            },
          ),
          SizedBox(height: 35),
          //color
          Text("Color",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          ColorFilter(
            onColorSelected: (colors) {
              setState(() {
                selectedColors = colors;
              });
            },
          ),
          SizedBox(height: 35),
          //Star Rating
          Text("Star Rating",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          RatingFilter(
            onratingSelected: (ratingValue) {
              setState(() {
                rating = ratingValue;
              });
            },
          ),
          SizedBox(height: 35),
          //Category
          Text("Category",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          CategoryFilter(
            onCategorySelected: (int categoryId) {
              setState(() {
                selectedCategory = categoryId;
              });
            },
          ),
          SizedBox(height: 35),
          //discount
          Text("Discount",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          DiscountFilter(
            ondiscountSelected: (discountList) {
              setState(() {
                discounts = discountList;
              });
            },
          ),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    //#####7
                    minPrice = 0;
                    maxPrice = 100;
                    selectedColors = [];
                    rating = 0;
                    selectedCategory = 0;
                    discounts = [];
                  });
                },
                child: Text("Reset"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTextColor, foregroundColor: kbarColor),
              ),
              ElevatedButton(
                onPressed: () async {
                  //#######8
                  FilterApi api = FilterApi();
                  try {
                    List<Product> results = await api.filterProducts(
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                      colors: selectedColors,
                      rating: rating,
                      category: selectedCategory,
                      discounts: discounts,
                    );
                    print("✅ Produits filtrés: ${results.length}");
                    widget.onFilteredResults(results); 
                    Navigator.pop(context);
                    // widget.onFilteredResults(results);
                  } catch (e) {
                    print("❌ Erreur de filtre: $e");
                  }
                },
                child: Text("Apply"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kIconColor, foregroundColor: kbarColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
