import 'dart:math';

import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0; // Default to the first category

  final List<Map<String, String>> categories = [
    {"name": "dresses", "image": "assets/categories/category1.jpg"},
    {"name": "tops", "image": "assets/images/men.png"},
    {"name": "Accessories", "image": "assets/images/accessories.png"},
    {"name": "Beauty", "image": "assets/images/beauty.png"},
    {"name": "pants", "image": "assets/images/beauty.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment:
                Alignment.centerRight, // Pushes the categories to the right
            height: 100, // Adjust based on your category size
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              shrinkWrap:
                  true, // Ensures the ListView doesn't take up unnecessary space
              itemBuilder: (context, index) {
                bool isSelected = index == selectedIndex;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Spacing between items
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        // Image in a circle
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF3A2C27)
                                : Color(0xFFF3F3F3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              categories[index]["image"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Category name text
                        Text(
                          categories[index]["name"]!,
                          style: TextStyle(
                            color: isSelected
                                ? Color(0xFF3A2C27)
                                : Color(0xFF9D9D9D),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
