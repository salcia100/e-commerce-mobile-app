import 'package:inscri_ecommerce/constant/constant.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['avatar']['image_path'] != null
        ? json['avatar']['image_path'].replaceAll("127.0.0.1", IPv4)
        : "default_image_url.jpg"; // Valeur par défaut si image est null
    imageUrl = imageUrl + "?${DateTime.now().minute}";

    print("image url : " + imageUrl);

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: imageUrl,
    );
  }
}
