import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Product_api.dart';
import 'package:inscri_ecommerce/screens/home/components/body.dart';
import 'package:inscri_ecommerce/screens/profile_sidebar.dart';
import 'components/buttomBar.dart';
import 'components/appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductApi apiService = ProductApi();
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      List<dynamic> data = await apiService.getProducts();
      print("Products loaded: ${data.length}");
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

  // Added method to handle pull-to-refresh
  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      appBar: CustomAppBar(onProfilePressed: () {
        _scaffoldKey.currentState?.openDrawer(); // Ouvre le sidebar
      }),
      drawer: ProfileSidebar(),
      body: Body(products: products, onRefresh: onRefresh),
      bottomNavigationBar: BottomBar(onRefresh: onRefresh),
    );
  }
}
