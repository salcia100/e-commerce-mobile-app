class LoginResponseModel {
  late String token;
  late String error;

  LoginResponseModel({this.token = "", this.error = ""});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["data"] != null ? json["data"]["token"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class LoginRequestModel {
  late String email;
  late String password;
  LoginRequestModel({
    this.email = "",
    this.password = "",
  });
  Map<String, dynamic> toJson() {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("email ,password should not be empty");
    }
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
