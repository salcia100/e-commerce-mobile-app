import 'package:inscri_ecommerce/constant/constant.dart';

class Cart {
  int id;
  String title;
  String size;
  String color;
  double price;
  int quantity;
  String imagePath;

  Cart({
    required this.id,
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    // Si l'image est dans l'objet "product"
    String imageUrl = json['product']['image'];

    // Vérifie et remplace l'IP si nécessaire
    if (imageUrl.contains("127.0.0.1")) {
      imageUrl = imageUrl.replaceAll("127.0.0.1", IPv4);
    }


    print("image url : " + imageUrl);

    return Cart(
      id: int.parse(json['id'].toString()),
      title: json['product']['name'],
      size: "s",
      color: "red",
      imagePath: imageUrl,
      price: double.parse(json['product']['price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
    );
  }
}
