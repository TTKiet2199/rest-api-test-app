import 'dart:convert';

import 'package:rest_api_test_app/data_sources/api_urls.dart';
import 'package:rest_api_test_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<UserModel>> fetchUserModel() async {
    final result = await http.get(ApiUrls().API_USER_LIST);

    final String jsonBody = result.body;
    final int statusCode = result.statusCode;
    if (statusCode != 200) {
      print(result.reasonPhrase);
      throw Exception("error");
    }
    final useListContainer = jsonDecode(jsonBody);
    final List userList = useListContainer['results'];
    final response = userList.map((e) => UserModel.fromJson(e)).toList();
    return response;
  }
}
