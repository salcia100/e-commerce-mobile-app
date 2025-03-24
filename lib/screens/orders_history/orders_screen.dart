import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Orders_api.dart';
import 'package:inscri_ecommerce/model/order.dart';
import 'package:inscri_ecommerce/screens/orders_history/components/OrderItem.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersApi apiService = OrdersApi();
  List<dynamic> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      List<dynamic> data = await apiService.getOrdersHistory();
      setState(() {
        orders = data;
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
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'My Orders',
            style: TextStyle(
              color: Color(0xFF1D1F22),
              fontSize: 18,
              fontFamily: 'Product Sans',
            ),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh, //
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orders[index]);
            },
          ),
        ));
  }
}
