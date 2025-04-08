import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/Product.dart';
import 'package:inscri_ecommerce/screens/My_shop/components/edit_product_body.dart';



void showEditProductModal(BuildContext context, int productId, Product product,onRefrech) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: EditProductBody(productId: productId, product: product,onRefresh:onRefrech),
    ),
  );
}
