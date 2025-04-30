import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/customOrder_api.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/custom_form.dart';
import 'package:inscri_ecommerce/screens/custom_form/custom_form_screen.dart';
import 'package:inscri_ecommerce/screens/customised_orders/components/fullScreenImage.dart';
import 'package:inscri_ecommerce/model/Category.dart';
import 'package:inscri_ecommerce/api/category_api.dart';
import 'package:inscri_ecommerce/utils/toast.dart';

class CustomOrder extends StatefulWidget {
  const CustomOrder({super.key});

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  List<CustomOrders> orders = [];
  List<bool> _expandedList = [];
  List<Category> categories = [];
  bool isLoading = true;

  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    loadInitialData();
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await fetchCategories();
    await fetchOrders();
  }

  // récupérer toutes les catégories
  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await CategoryApi().getCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('❌ Erreur fetchCategories: $e');
    }
  }

  //récupérer les commandes personnalisées
  Future<void> fetchOrders() async {
    try {
      var fetchedOrders = await CustomOrdersApi().getAvailableCustomOrders();
      setState(() {
        orders = fetchedOrders;
        _expandedList = List.filled(orders.length, false);
        isLoading = false;
      });
    } catch (e) {
      print('❌ Erreur fetchOrders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  //obtenir le nom de la catégorie en fonction de l'id
  String getCategoryName(int? categoryId) {
    if (categoryId == null) return "Catégorie inconnue";
    final category = categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => Category(id: 0, name: "Catégorie inconnue", image: ''),
    );
    return category.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final isExpanded = _expandedList[index];

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      order.client?.image ??
                                          "https://url_image_default.jpg"),
                                  radius: 30,
                                ),
                                const SizedBox(height: 6),
                                Text(order.client?.name ?? "Nom inconnu",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order.title,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text("Budget : ${order.budget}"),
                                  const SizedBox(height: 4),
                                  Text("Category : ${getCategoryName(order.categoryId)}"),
                                  const SizedBox(height: 4),
                                  if (isExpanded) ...[
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                                    imageUrl: order.image),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          order.image,
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Description : ${order.description}"),
                                    const SizedBox(height: 10),
                                    Text("Color : ${order.color}"),
                                    const SizedBox(height: 4),
                                    Text("Material : ${order.material}"),
                                  ],
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _expandedList[index] =
                                                !_expandedList[index];
                                          });
                                        },
                                        child: Text(isExpanded
                                            ? "Hide Details"
                                            : "Details"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            await CustomOrdersApi()
                                                .acceptCustomOrder(order.id);
                                            setState(() {
                                              // Mettez à jour l'état de la commande (par exemple, pour refléter qu'elle est acceptée)
                                            });
                                            successToast("Order accepted!");
                                          } catch (e) {
                                            errorToast("Erreur: $e");
                                          }
                                        },
                                        child: const Text("Accepted"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CustomFormScreen(onRefresh: onRefresh)),
          );
        },
        label: const Text("Place Custom Order"),
        icon: const Icon(Icons.add),
        backgroundColor: kIconColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
