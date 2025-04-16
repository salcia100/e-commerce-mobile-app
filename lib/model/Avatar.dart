import 'package:inscri_ecommerce/constant/constant.dart';

class Avatar {
  final int id;
  final String image;

  Avatar({required this.id, required this.image});

  // Factory method to create an Avatar from a JSON object
  factory Avatar.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image_path'] != null
        ? json['image_path'].replaceAll("127.0.0.1", IPv4)
        : "default_image_url.jpg"; // Valeur par défaut si image est null
    imageUrl = imageUrl + "?${DateTime.now().minute}";

    print("image url : " + imageUrl);

    return Avatar(
      id: json['id'],
      image: imageUrl,
    );
  }

  // Convert Avatar object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
