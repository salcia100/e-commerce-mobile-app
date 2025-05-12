class CheckoutRequestModel {
  late String name;
  late String shipping_address;
  late String phone;
  late String paymentMethod;

  CheckoutRequestModel({
    this.name = "",
    this.shipping_address = "",
    this.phone = "",
    this.paymentMethod = "",
  });

  Map<String, dynamic> toJson() {
    if (name.isEmpty || shipping_address.isEmpty || phone.isEmpty ) {
      throw Exception("name ,shipping_address ,phone should not be empty");
    }
    return {
      'name': name.trim(),
      'shipping_address': shipping_address.trim(),
      'phone': phone.trim(),
      'payment_method': paymentMethod.trim(),
    };
  }
}

class CheckoutResponseModel {
  late String payment_url;
  late String error;

  CheckoutResponseModel({this.payment_url = "", this.error = ""});

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
        payment_url: json["url"] ?? "", // if json["token"] is null, use ""
        error: json["error"] ?? "");
  }
}
