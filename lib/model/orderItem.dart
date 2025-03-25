class OrderItem {
  final int order_id;
  final String product_name;
  final int quantity;
  final double price;

  OrderItem({
    required this.order_id,
    required this.product_name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      order_id: json['id'],
      quantity: json['quantity'],
      price: double.parse(json['price']),
      product_name: json['product']['name'],
    );
  }
}
