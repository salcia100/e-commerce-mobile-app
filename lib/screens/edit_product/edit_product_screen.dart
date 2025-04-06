import 'package:flutter/material.dart';

import 'package:inscri_ecommerce/screens/add_product/components/appBar.dart';
import 'package:inscri_ecommerce/screens/edit_product/components/edit_product_body.dart';
import 'package:inscri_ecommerce/screens/home/components/buttomBar.dart';

class EditProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddProductAppBar(),
      body: EditProductBody(),    
      bottomNavigationBar: BottomBar(),
    );
  }
}
