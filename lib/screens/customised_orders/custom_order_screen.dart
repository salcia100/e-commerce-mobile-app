import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/customised_orders/components/appBar_custom.dart';

import 'package:inscri_ecommerce/screens/customised_orders/components/custom_order.dart';

class CustomOrderScreen extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  const CustomOrderScreen({required this.onRefresh});

  @override
  State<CustomOrderScreen> createState() => _CustomOrderScreenState();
}

class _CustomOrderScreenState extends State<CustomOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomOrder(),
    );
  }
}
