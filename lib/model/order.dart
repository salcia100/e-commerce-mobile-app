import 'package:inscri_ecommerce/model/orderItem.dart';
import 'package:intl/intl.dart';

class Order {
  final int id;
  final String date;
  final String shipping_address;
  final int quantity;
  final double subtotal;
  final String status;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.date,
    required this.shipping_address,
    required this.quantity,
    required this.subtotal,
    required this.status,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['order_item'] as List;
    List<OrderItem> orderItems =
        list.map((i) => OrderItem.fromJson(i)).toList();

    return Order(
      id: int.parse(json['id'].toString()),
      date: DateFormat('dd/MM/yyyy HH:mm')
          .format(DateTime.parse(json['created_at'])),
      shipping_address: json['shipping_address'],
      status: json['status'],
      subtotal: double.parse(json['total_price'].toString()),
      quantity: int.parse(json['total_quantity'].toString()),
      orderItems: orderItems,
    );
  }
}
