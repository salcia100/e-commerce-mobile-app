import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/add_product/components/addProduct_body.dart';
import 'package:inscri_ecommerce/screens/add_product/components/appBar.dart';

class AddProductScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const AddProductScreen({required this.onRefresh});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddProductAppBar(),
      body: AddProductBody(onRefresh:widget.onRefresh),
      //bottomNavigationBar: BottomBar(),
    );
  }
}
