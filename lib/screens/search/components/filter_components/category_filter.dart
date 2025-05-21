import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/api/category_api.dart'; 

class CategoryFilter extends StatefulWidget {
  final Function(int) onCategorySelected; 

  CategoryFilter({required this.onCategorySelected}); 

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final CategoryApi categoryApiService = CategoryApi();
  List<Category> categories = [];
  int selectedCategory = 1; 

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      List<Category> categorieData = await categoryApiService.getCategories();
      print("Categories loaded: ${categorieData.length}");
      setState(() {
        categories = categorieData; 
      selectedCategory = 1; // id par défaut
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedCategory,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          items: categories.map((category) {
            return DropdownMenuItem<int>(
              value: category.id, // Assuming category has an id property
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (int? value) {
            setState(() {
              selectedCategory = value!;
            });
            widget.onCategorySelected(value!); // Pass int
          },
        ),
      ),
    );
  }
}
