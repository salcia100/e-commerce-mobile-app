import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/product_api.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/screens/home/components/body.dart';
import 'package:inscri_ecommerce/screens/profile_sidebar/profile_sidebar.dart';
import 'components/bottomBar.dart';
import 'components/homeAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductApi apiService = ProductApi();
  final CategoryApi categoryApiService = CategoryApi();

  List<dynamic> products = [];
  List<Category> categories = [];
  bool isLoading = true;
  int selectedCategoryId = -1; // to store selected category id

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchProducts();
  }

  void fetchCategories() async {
    try {
      List<Category> categorieData = await categoryApiService.getCategories();
      print("Categories loaded: ${categorieData.length}");
      setState(() {
        categories = categorieData;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  //if All or nothing selected it shows all products if another categorie selected it shows with categoryapi depend on id
  void fetchProducts({int? categoryId}) async {
    try {
      List<dynamic> data = (categoryId == null || categoryId == -1)
          ? await apiService.getProducts() // All products
          : await categoryApiService
              .getCategoryProducts(categoryId); // Filtered

      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Callback for category change
  void onCategorySelected(int categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
      isLoading = true;
    });
    fetchProducts(
        categoryId: categoryId); // Fetch products of the selected category
  }

  // Added method to handle pull-to-refresh
  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchCategories();
    fetchProducts(
      categoryId: selectedCategoryId != -1 ? selectedCategoryId : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: HomeAppBar(onProfilePressed: () {
        _scaffoldKey.currentState?.openDrawer(); // Ouvre le sidebar
      }),
      drawer: ProfileSidebar(),
      body: Body(
          products: products,
          categories: categories,
          onRefresh: onRefresh,
          onCategorySelected:
              onCategorySelected), // to listen for the selected category
      bottomNavigationBar:
          BottomBar(onRefresh: onRefresh, initialIndex: 0), // Pass the initial
    );
  }
}
