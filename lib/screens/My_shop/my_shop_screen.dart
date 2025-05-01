import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/product_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/appBar_myShop.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/my_shop_body.dart';
import 'package:inscri_ecommerce/screens/home/components/bottomBar.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  final ProductApi apiService = ProductApi();

  List<Product> VendorProducts = [];

  bool isLoading = true;

  Future<void> fetchVendorProducts() async {
    try {
      List<Product> data = await apiService.getVendorProducts();
      print("Products loaded: ${data.length}");
      setState(() {
        VendorProducts = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchVendorProducts();
  }

  @override
  void initState() {
    super.initState();
    fetchVendorProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyShopAppBar(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: MyShopBody(
            VendorProducts: VendorProducts, onRefresh: fetchVendorProducts),
      ),
      bottomNavigationBar: BottomBar(onRefresh:onRefresh),
    );
  }
}
