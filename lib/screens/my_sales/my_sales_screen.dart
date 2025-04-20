import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Orders_api.dart';
import 'package:inscri_ecommerce/model/sale.dart';
import 'package:inscri_ecommerce/screens/my_sales/components/salesItem.dart';

class SalesScreen extends StatefulWidget {
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final OrdersApi apiService = OrdersApi();
  List<Sale> sales = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSales();
  }

void fetchSales() async {
  try {
    List<Sale> data = await apiService.getMySales();
    print("Sales Data: $data");  
    setState(() {
      sales = data;
      isLoading = false;
    });
  } catch (e) {
    print("Erreur : $e");
    setState(() {
      isLoading = false;
    });
  }
}
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Sales',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: sales.length,
                itemBuilder: (context, index) {
                  return SalesItem(sale: sales[index]);
                },
              ),
            ),
    );
  }
}
