import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';

class CustomOrderWidget extends StatefulWidget {
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
  State<CustomOrderWidget> createState() => _CustomOrderWidgetState();
}

class _CustomOrderWidgetState extends State<CustomOrderWidget> {
  bool _isExpanded = false; // Variable to track the expanded state

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Custom Order ⭐ #${widget.order.id}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('title: ${widget.order.title}'),
              Text('Quantity: ${widget.order.quantity}'),
              Text('budget: \$${widget.order.budget}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Vendor Info
                          Row(
                            children: [
                              Icon(Icons.store, color: Colors.deepPurple),
                              SizedBox(width: 8),
                              Text(
                                widget.order.vendor?.name ?? "No vendor yet",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),

                          // Buttons
                          Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  side: BorderSide(color: Colors.green),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                onPressed: widget.onConfirmVendor,
                                child: Text("Confirm"),
                              ),
                              SizedBox(width: 8),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: BorderSide(color: Colors.red),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                ),
                                onPressed: widget.onCancelVendor,
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.order.status,
                    style: TextStyle(
                      color: widget.order.status == 'confirmed'
                          ? Colors.orange
                          : widget.order.status == 'PAID'
                              ? Colors.blue
                              : widget.order.status == 'CANCELED'
                                  ? Colors.red
                                  : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle the expanded state
                      });
                    },
                    child: Text(_isExpanded ? 'Hide Details' : 'Details'),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 10), // Adds space before the product list
                Divider(color: Colors.grey), // Optional separator
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Coins arrondis
                  child: Image.network(
                    widget.order.image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${widget.order.description}'),
                        Text('Material: ${widget.order.material}'),
                        Text('Color: ${widget.order.color}'),
                      ]),
                ),
              ],
            ],
          ),
        ));
  }
}
/*Card(
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
    );*/
