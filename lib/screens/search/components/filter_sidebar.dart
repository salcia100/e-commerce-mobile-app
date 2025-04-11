import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/category_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/discount_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/color_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/price_filter.dart';
import 'package:inscri_ecommerce/screens/search/components/filter_components/rating_filter.dart';

class FilterSidebar extends StatefulWidget {
  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<FilterSidebar> {
  //price
  RangeValues _currentRange = RangeValues(10, 80);

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
          PriceFilter(),
          SizedBox(height: 35),
          //color
          Text("Color",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          ColorFilter(),
          SizedBox(height: 35),
          //Star Rating
          Text("Star Rating",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          RatingFilter(),
          SizedBox(height: 35),
          //Category
          Text("Category",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          CategoryFilter(),
          SizedBox(height: 35),
          //discount
          Text("Discount",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF33302E))),
          SizedBox(height: 15),
          DiscountFilter(),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Reset"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTextColor, 
                    foregroundColor: kbarColor),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Apply"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kIconColor, 
                    foregroundColor: kbarColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
