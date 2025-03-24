import 'package:intl/intl.dart';

class Order {
  final int id;
  final String  date;
  final String shipping_address;
  final int quantity;
  final double subtotal;
  final String status;

  Order({
    required this.id,
    required this.date,
    required this.shipping_address,
    required this.quantity,
    required this.subtotal,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {

    return Order(
      id: int.parse(json['id'].toString()),
      date:DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(json['created_at'])), 
      shipping_address:json['shipping_address'],
      status: json['status'],
      subtotal: double.parse(json['total_price'].toString()),
      quantity: int.parse(json['total_quantity'].toString()),
    );
  }

  /*static List<Order> orders = [
    Order(
      id: 1524,
      date: "14/05/2021",
      shipping_address: "123 Main Street, City",
      //quantity: 2,
      subtotal: 110.0,
      status: "PENDING",
    ),
    Order(
      id: 1525,
      date: "14/05/2021",
      shipping_address: "123 Main Street, City",
      //quantity: 1,
      subtotal: 50.0,
      status: "SHIPPED",
    ),
    Order(
      id: 1526,
      date: "14/05/2021",
      shipping_address: "123 Main Street, City",
      //quantity: 2,
      subtotal: 40.0,
      status: "PAID",
    ),
    Order(
      id: 1527,
      date: "23/05/2021",
      shipping_address: "123 Main Street, City",
      //quantity: 4,
      subtotal: 70.0,
      status: "CANCELED",
    ),
  ];*/
}

