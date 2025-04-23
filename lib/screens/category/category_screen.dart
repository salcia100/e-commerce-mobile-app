import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/category/components/category_appBar.dart';
import 'package:inscri_ecommerce/screens/category/components/category_body.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/api/category_api.dart';

class CategoryScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const CategoryScreen({required this.onRefresh});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> mainCategories = [];
  final CategoryApi categoryApiService = CategoryApi();

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
        mainCategories = categorieData;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(),
      body: CategoryBody(mainCategories: mainCategories),
    );
  }
}
