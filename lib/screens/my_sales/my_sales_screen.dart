import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Orders_api.dart';
import 'package:inscri_ecommerce/api/customOrder_api.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/model/sale.dart';
import 'package:inscri_ecommerce/screens/my_sales/components/custom_sales_item.dart';
import 'package:inscri_ecommerce/screens/my_sales/components/salesItem.dart';

class SalesScreen extends StatefulWidget {
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final OrdersApi apiService = OrdersApi();
  final CustomOrdersApi customOrdersApi = CustomOrdersApi();

  List<Sale> sales = [];
  List<CustomOrders> customSales = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSales();
  }

  void fetchSales() async {
    try {
      List<Sale> data = await apiService.getMySales();
      List<CustomOrders> customOrdersData = await customOrdersApi.getVendorCustomSales();
      print("Sales Data: $data");
      setState(() {
        sales = data;
        customSales = customOrdersData;
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
    List<dynamic> allSales = [...customSales, ...sales];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,//backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),//icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Sales',
            style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),//color: Colors.black, fontSize: 18)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: allSales.length,
              itemBuilder: (context, index) {
                final item = allSales[index];
                if (item is Sale) {
                  return SalesItem(sale: item); // widget existant
                } else if (item is CustomOrders) {
                  return CustomSalesItem(customOrder: item); // crée ce widget
                } else {
                  return SizedBox(); // au cas où
                }
              },
              ),
            ),
    );
  }
}
