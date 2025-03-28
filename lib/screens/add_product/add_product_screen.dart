
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/add_product/components/addProduct_body.dart';
import 'package:inscri_ecommerce/screens/add_product/components/appBar.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';



class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddProductAppBar(),
      body: AddProductBody(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
