import 'package:chat/model/user_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/group_detail.dart';


class ApiServiceAuthentication {
  static const String baseUrl = 'https://b04d-115-74-189-104.ngrok-free.app/api/v1';
  //static const String baseUrl = 'http://13.214.193.32/api/v1';

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
        // print(user.data?.id);
        // print(user.data?.role);
        // print(user);
        return user;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Đăng ký thất bại');
    }
  }
  Future<GroupResponse> getUserDetail(String userId) async {
    final url = Uri.parse('$baseUrl/group/detail/$userId');

    final headers = {
      'accept': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        // Xử lý dữ liệu khi thành công
        var group = GroupResponse.fromJson(responseData);
        print("3333333333333333");
        print(group.data);
        return group;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Gọi API thất bại');
    }
  }
}
