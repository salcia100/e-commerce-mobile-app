import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/wishlist_api.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';
import 'package:inscri_ecommerce/screens/wishlist/components/appBar.dart';
import 'package:inscri_ecommerce/screens/wishlist/components/wishlist_body.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishListApi apiService = WishListApi();
  List<Product> likedproducts = [];
  bool isLoading = true;

  Future<void> fetchWishlist() async {
    try {
      List<Product> data = await WishListApi.GetLikes();
      print("Products loaded: ${data.length}");
      setState(() {
        likedproducts = data;
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
    fetchWishlist();
  }

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: WishlistBody(
            likedproducts: likedproducts, onRefresh: fetchWishlist),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
