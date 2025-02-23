import 'package:http/http.dart' as http;
import 'package:inscri_ecommerce/constant/constant.dart';
import 'dart:convert';

import 'package:inscri_ecommerce/model/user/register_model.dart';

class API {
  Future<RegisterResponseModel> Register(RegisterRequestModel requestModel) async{
    String url=apiURL+'/auth/register';
    final response=await http.post(Uri.parse(url) ,body: requestModel.toJson());

    // Log status code and response body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if(response.statusCode ==200 || response.statusCode ==400){
      return RegisterResponseModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load Data Status code: ${response.statusCode}');
    }
  }
}
