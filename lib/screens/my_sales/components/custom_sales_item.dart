import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/custom_orders.dart';
import 'package:inscri_ecommerce/screens/customised_orders/components/fullScreenImage.dart';

class CustomSalesItem extends StatefulWidget {
  final CustomOrders customOrder;
  const CustomSalesItem({
    required this.customOrder,
  });
  @override
  State<CustomSalesItem> createState() => _CustomSalesItemState();
}

class _CustomSalesItemState extends State<CustomSalesItem> {
  bool _isExpanded = false; // Variable to track the expanded state
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
        children: [
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.customOrder.client?.image ??
                            "https://url_image_default.jpg"),
                    radius: 30,
                  ),
                  const SizedBox(height: 6),
                  Text(widget.customOrder.client?.name ?? "Nom inconnu",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Order ⭐ #${widget.customOrder.id}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Title : ${widget.customOrder.title}"),
                    const SizedBox(height: 4),
                    Text("Budget : ${widget.customOrder.budget}"),
                    const SizedBox(height: 4),
                    Text("Category : ${widget.customOrder.category?.name}"),
                    const SizedBox(height: 4),
                    Text(
                    widget.customOrder.status,
                    style: TextStyle(
                      color: widget.customOrder.status == 'confirmed'
                          ? Colors.orange
                          : widget.customOrder.status == 'PAID'
                              ? Colors.blue
                              :widget.customOrder.status == 'CANCELED'
                                  ? Colors.red
                                  : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(_isExpanded ? 'Hide' : 'Details'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  textStyle: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          if (_isExpanded) ...[
            SizedBox(height: 10), // Adds space before the product list
            Divider(color: Colors.grey),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImage(imageUrl: widget.customOrder.image),
                    ),
                  );
                },
                child: ClipRRect(         //image arrondie
                  borderRadius: BorderRadius.circular(12), 
                  child: Image.network(
                    widget.customOrder.image,
                    height: 150,
                    width: double.infinity,    //remplit l'espace
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${widget.customOrder.description}'),
                    Text('Material: ${widget.customOrder.material}'),
                    Text('Color: ${widget.customOrder.color}'),
                  ]),
            ),
          ],
        ],
      ),
    );
  }
}
