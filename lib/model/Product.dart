import 'package:inscri_ecommerce/constant/constant.dart';

class Product {
  String image, name, description;
  int stock, id;
  double price;
  List<String> reviews;
  //Color color;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.stock,
    required this.reviews,

    //required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    //String imageUrl = json['image'].replaceAll("127.0.0.1", "10.0.2.2");
    //String imageUrl = json['image'].replaceAll("127.0.0.1", "172.16.15.218");
    String imageUrl = json['image'] != null
        ? json['image'].replaceAll("127.0.0.1", IPv4)
        : "default_image_url.jpg"; // Valeur par défaut si image est null
    imageUrl = imageUrl + "?${DateTime.now().minute}"; // Append timestamp

    print("image url : " + imageUrl);
    return Product(
      id: json['id'],
      name: json['name'] ?? 'No name available',
      image: imageUrl,
      price: double.parse(json['price'].toString()),
      description: json['description'] ?? 'No description available',
      stock: int.parse(json['stock'].toString()),
      reviews: [
        "Super produit !",
        "Très satisfait de mon achat.",
        "Livraison rapide et conforme.",
      ],
    );
  }
}
