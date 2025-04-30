import 'product.dart';

class Sale {
  final int id;
  final String name;
  final Product product;
  final int quantity;
  final DateTime date;

  Sale({
    required this.id,
    required this.name,
    required this.product,
    required this.quantity,
    required this.date,
  });

  factory Sale.fromOrderItem(Map<String, dynamic> orderItem, String date,int id,String name) {
    return Sale(
      id:id,
      name: name,
      product: Product.fromJson(orderItem['product']),
      quantity: orderItem['quantity'],
      date: DateTime.parse(date),

    );
  }
  @override
  String toString() {
    return 'Sale(id: $id, title: $name, price: ${product.price}, quantity: $quantity, date: $date)';
  }
}
