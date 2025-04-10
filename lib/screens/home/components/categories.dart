import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Category.dart';

class Categories extends StatefulWidget {
  final List<Category> categories;
  final Function(int) onCategorySelected; // Add this callback

  Categories({required this.categories, required this.onCategorySelected});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0; // Default to the first category

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // alignment:
            //  Alignment.centerRight, // Pushes the categories to the right
            height: 100, // Adjust based on your category size
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
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
                      // If the first category ("Women") is tapped, send -1 to fetch all products
                      if (index == 0) {
                        widget.onCategorySelected(-1); // -1 means "show all products"
                      } else {
                        widget.onCategorySelected(widget.categories[index].id); // Normal category
                      }
                    },
                    child: Column(
                      children: [
                        // Image in a circle
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF3A2C27)
                                : Color(0xFFF3F3F3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.categories[index]
                                  .image, // Image URL from API
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Category name text
                        Text(
                          widget.categories[index].name,
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
