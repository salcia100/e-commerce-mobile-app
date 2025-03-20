class OrderItems {
  final int order_id;
  final String product_name;
  final int quantity;
  final double price;

  OrderItems({
    required this.order_id,
    required this.product_name,
    required this.quantity,
    required this.price,
  });

  static List<OrderItems> orderIems = [
    OrderItems(
      order_id: 1524,
      product_name: "Maxi Dress",
      quantity: 2,
      price: 110.0,
    ),
    OrderItems(
      order_id: 1524,
      product_name: "linen Dress",
      quantity: 4,
      price: 13.0,
    ),
    OrderItems(
      order_id: 1524,
      product_name: "pinky top",
      quantity: 1,
      price: 120.0,
    ),
  ];
}
