import 'package:chat/model/user_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ApiServiceAuthentication {
  static const String baseUrl = 'http://13.214.193.32:3000/api/v1';

  Future<UserResponse> registerUser(String userIP) async {
    final url = Uri.parse('$baseUrl/user/register');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // Xây dựng body dưới dạng raw
    final rawBody = '{"userIP":"$userIP"}';

    final response = await http.post(url, headers: headers, body: rawBody);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        // Đăng ký thành công
        var user = UserResponse.fromJson(responseData);
        print(user.data?.id);
        print(user.data?.role);
        print(user);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userID', user.data?.id as String? ?? '');
        prefs.setInt('userRole', user.data?.role as int? ?? 0);
        return user;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Đăng ký thất bại');
    }
  }
  Future<UserResponse> loginUser(String userIP) async {
    final url = Uri.parse('$baseUrl/user/login');

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // Xây dựng body dưới dạng raw
    final rawBody = '{"userIP":"$userIP"}';

    final response = await http.post(url, headers: headers, body: rawBody);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        // Đăng ký thành công
        var user = UserResponse.fromJson(responseData);
        print(user.data?.id);
        print(user.data?.role);
        print(user);
        return user;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Đăng ký thất bại');
    }
  }
}
