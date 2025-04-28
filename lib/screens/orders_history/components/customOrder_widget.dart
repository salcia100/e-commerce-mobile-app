import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';

class CustomOrderWidget extends StatelessWidget {
  final CustomOrders order;
  final VoidCallback onConfirmVendor;
  final VoidCallback onCancelVendor;

  const CustomOrderWidget({
    Key? key,
    required this.order,
    required this.onConfirmVendor,
    required this.onCancelVendor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: NetworkImage(order.client?.image ?? "https://url_image_default.jpg"),
                      radius: 30,
                    ),
                    const SizedBox(height: 6),
                    Text(order.client?.name ?? "Nom inconnu", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                    'Order #${order.id}',
                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Title : ${order.title}"),
                      const SizedBox(height: 4),
                      Text("Budget : ${order.budget}"),
                      const SizedBox(height: 4),
                      Text("Category : ${order.categoryId}"),
                      const SizedBox(height: 4),
                      // Confirm Vendor button
                      Row(
                        children: [
                      ElevatedButton(
                        onPressed: () async {
                        onConfirmVendor();
                        },
                        child: const Text("Confirm"),
                      ),
                      // Cancel Vendor button
                      ElevatedButton(
                        onPressed: () async {
                         onCancelVendor();
                        },
                        child: const Text("Cancel"),
                      ),
                    ],),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
