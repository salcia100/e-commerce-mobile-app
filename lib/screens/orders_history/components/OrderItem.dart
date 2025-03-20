import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/model/order.dart';
import 'package:inscri_ecommerce/model/orderItems.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  List<OrderItems> orderItems = OrderItems.orderIems;
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
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${widget.order.id}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Date: ${widget.order.date}'),
              Text('Tracking: ${widget.order.shipping_address}'),
              Text('Quantity: ${widget.order.quantity}'),
              Text('Subtotal: \$${widget.order.subtotal}'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.order.status,
                    style: TextStyle(
                      color: widget.order.status == 'PENDING'
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: orderItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.product_name,
                                style: TextStyle(fontSize: 16)),
                            Text('${item.quantity}x',
                                style: TextStyle(fontSize: 16)),
                            Text('\$${item.price}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ));
  }
}
