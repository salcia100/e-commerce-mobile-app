class RegisterResponseModel {
  late String token;
  late String error;

  RegisterResponseModel({this.token = "", this.error = ""});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
        token: json["token"] ?? "", // if json["token"] is null, use ""
        error: json["error"] ?? "");
  }
}

class RegisterRequestModel {
  late String name;
  late String email;
  late String password;
  late String password_confirmation;

  RegisterRequestModel({
    this.name="",
    this.email="",
    this.password="",
    this.password_confirmation=""});

  Map<String, dynamic> toJson() {
    if (name.isEmpty|| email.isEmpty || password.isEmpty || password_confirmation.isEmpty) {
      throw Exception(
          "name ,email ,password and password_confirmation should not be empty");
    }
    return {
      'name': name.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'password_confirmation': password_confirmation.trim(),
    };
  }
}
