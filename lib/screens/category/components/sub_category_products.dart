import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/screens/details_produit/details_screen.dart';
import 'package:inscri_ecommerce/screens/home/components/item_card.dart';

class SubCategoryProducts extends StatefulWidget {
  final Category  subCategory;
  const SubCategoryProducts({Key? key, required this.subCategory})
      : super(key: key);

  @override
  _SubCategoryProductsState createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  List<dynamic> SubCategoryProducts = [];
  final CategoryApi categoryApiService = CategoryApi();

  @override
  void initState() {
    super.initState();
    fetchSubCategoryProducts(widget.subCategory.id);
  }
  void fetchSubCategoryProducts(int id) async {
    try {
      List<dynamic> products = await categoryApiService.getCategoryProducts(id);
      setState(() {
        SubCategoryProducts = products;
      });
    } catch (e) {
      print("Error fetching subcategory products: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        " ${widget.subCategory.name} SubCategory",
        style: TextStyle(
           color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 18,
          fontFamily: 'Product Sans',
        ),
      ),
      centerTitle: true,
    ),
      body: GridView.builder(
              itemCount: SubCategoryProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: SubCategoryProducts[index],
                press: () {
                  print("Tapped on ${SubCategoryProducts[index].name}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: SubCategoryProducts[index],
                        ),
                      ));
                },
              ),
            ),
    );
  }
}