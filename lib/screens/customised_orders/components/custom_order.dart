/*import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/custom_form.dart';

class CustomOrder extends StatelessWidget {
  const CustomOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = List.generate(
        3,
        (index) => {
              "username": "Client$index",
              "title": "Produit Personnalisé $index",
              "description": "Une belle demande pour un produit unique $index",
              "category":"category $index",
              "budget": "\$${50 + index * 20}",
              "image": "https://i.pravatar.cc/150?img=${index + 1}"
            });

    return Scaffold(
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(order["image"]!),
                        radius: 30,
                      ),
                      const SizedBox(height: 6),
                      Text(order["username"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order["title"]!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(order["description"]!),
                        const SizedBox(height: 4),
                        Text("Budget : ${order["budget"]}"),
                        const SizedBox(height: 4),
                         Text(order["category"]!),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Action: Accepter commande
                            },
                            child: const Text("Accepted"),
                          ),
                        )
                      ],
                    ),
                  )
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
            MaterialPageRoute(builder: (_) => CustomForm()),
          );
        },
        
        label: const Text("Place Custom Order"),
        icon: const Icon(Icons.add),
          backgroundColor: kIconColor,
          foregroundColor: Colors.white,  
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/theme_constants.dart';
import 'package:inscri_ecommerce/screens/custom_form/component/custom_form.dart';

class CustomOrder extends StatefulWidget {
  const CustomOrder({super.key});

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  late List<Map<String, String>> orders;
  List<bool> _expandedList = [];

  @override
  void initState() {
    super.initState();
    orders = List.generate(
        3,
        (index) => {
              "username": "Client$index",
              "title": "Produit Personnalisé $index",
              "description": "Une belle demande pour un produit unique $index",
              "category": "category $index",
              "budget": "\$${50 + index * 20}",
              "image": "https://i.pravatar.cc/150?img=${index + 1}"
            });
    _expandedList = List.filled(orders.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
                            backgroundImage: NetworkImage(order["image"]!),
                            radius: 30,
                          ),
                          const SizedBox(height: 6),
                          Text(order["username"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order["title"]!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("Budget : ${order["budget"]}"),
                              const SizedBox(height: 4),
                            Text(order["category"]!),
                              const SizedBox(height: 4),
                            if (isExpanded) ...[
                              Text(order["description"]!),
                              const SizedBox(height: 4),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _expandedList[index] =
                                          !_expandedList[index];
                                    });
                                  },
                                  child:
                                      Text(isExpanded ? "Hide Details" : "Details"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Action: Accepter commande
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
            MaterialPageRoute(builder: (_) => CustomForm()),
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

