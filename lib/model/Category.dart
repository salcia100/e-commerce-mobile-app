import 'package:inscri_ecommerce/constant/constant.dart';

class Category {
  String name, image;
  int id;

  Category({required this.image, required this.name, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] != null
        ? json['image'].replaceAll("127.0.0.1", IPv4)
        : "default_image_url.jpg";
    print("image url : " + imageUrl);

    return Category(
      id: json['id'],
      image: imageUrl,
      name: json['name'] ?? 'No name available',
    );
  }
}
