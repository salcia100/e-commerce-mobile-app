import 'package:inscri_ecommerce/constant/constant.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String image;
  final bool is_verified_seller;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.is_verified_seller,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String imageUrl = "default_image_url.jpg"; // Default image

    if (json['avatar'] != null && json['avatar']['image_path'] != null) {
      imageUrl = json['avatar']['image_path'].replaceAll("127.0.0.1", IPv4) +
          "?${DateTime.now().minute}";
    }

    print("image url : " + imageUrl);

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: imageUrl,
      /**Si json['is_verified_seller'] est true,ou si c’est égal à 1➜ alors on considère que c’est un vendeur vérifié → true */
      is_verified_seller:json['is_verified_seller'] == true || json['is_verified_seller'] == 1,
    );
  }
}
