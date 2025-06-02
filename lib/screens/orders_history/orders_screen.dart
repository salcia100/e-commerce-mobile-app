import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/Orders_api.dart';
import 'package:inscri_ecommerce/api/customOrder_api.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/model/order.dart';
import 'package:inscri_ecommerce/screens/orders_history/components/OrderItemWidget.dart';
import 'package:inscri_ecommerce/screens/orders_history/components/customOrder_widget.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersApi ordersApi = OrdersApi();
  final CustomOrdersApi customOrdersApi = CustomOrdersApi();

  List<dynamic> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Récupérer les commandes génériques (Orders) et les commandes personnalisées (CustomOrders)
  void fetchOrders() async {
    try {
      List<dynamic> ordersData = await ordersApi.getOrdersHistory();
      List<dynamic> customOrdersData = await customOrdersApi.getclientCustomOrders();
      
      setState(() {
        orders = [...customOrdersData, ...ordersData]; // Combine les deux listes
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Ajout de la méthode de pull-to-refresh
  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,   
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontSize: 18,
            fontFamily: 'Product Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];

            // Vérifier si l'élément est de type CustomOrders ou Order
            if (order is CustomOrders) {
              return CustomOrderWidget(order: order,
              onConfirmVendor: () async {
                          try {
                            await customOrdersApi.confirmVendor(order.id);
                             successToast("vendor confirmed!");
                          } catch (e) {
                            errorToast("Erreur: $e");
                          }
                        },
                        onCancelVendor: () async {
                          try {
                            await customOrdersApi.cancelVendor(order.id);
                            successToast("vendor cancelled!");
                          } catch (e) {
                           errorToast("Erreur: $e");
                          }
                        },);
            } else if (order is Order) {
              // Afficher OrderItemWidget pour les commandes génériques
              return OrderItemWidget(order: order);
            } else {
              // Affichage générique au cas où l'objet serait un autre type non prévu
              return ListTile(
                title: Text("Commande inconnue"),
                subtitle: Text("Détails indisponibles"),
              );
            }
          },
        ),
      ),
    );
  }
}
