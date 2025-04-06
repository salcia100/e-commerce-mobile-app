import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/appBar_myShop.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/my_shop_body.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  MyShopAppBar(),
      body:  MyShopBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
