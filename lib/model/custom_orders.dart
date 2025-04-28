import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/model/user/User.dart';

class CustomOrders {
  final int id;
  final String title;
  final String description;
  final String? budget;
  final String image;
  final User? client;
  final int categoryId;
   final String? color;
  final String? material;
  final String status;

  CustomOrders({
    required this.id,
    required this.title,
    required this.description,
    this.budget,
    required this.image,
    required this.client,
    required this.categoryId,
    this.color,
    this.material,
    required this.status,
  });


factory CustomOrders.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'];
    imageUrl = imageUrl.replaceAll("127.0.0.1", IPv4); 

    return CustomOrders(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      budget: json['budget']?.toString(),
      image: imageUrl,
      client: json['client'] != null ? User.fromJson(json['client']) : null,
      categoryId: json['category_id'],
       color: json['color'] ?? '',  
      material: json['material'] ?? '',
      status: json['status'],
    );
  }
}
