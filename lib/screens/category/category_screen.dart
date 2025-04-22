import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/category/components/category_appBar.dart';

import 'package:inscri_ecommerce/screens/category/components/category_body.dart';

class CategoryScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const CategoryScreen({required this.onRefresh});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(),
      body: CategoryBody(),
    );
  }
}
