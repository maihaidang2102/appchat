// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat/model/user_register.dart';

import '../model/group_detail.dart';

class ApiServiceAuthentication {
  // static const String baseUrl = 'https://3469-171-226-133-187.ngrok-free.app/api/v1';
  static const String baseUrl = 'http://13.214.193.32/api/v1';

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
        prefs.setString('userID', user.data?.id ?? '');
        prefs.setInt('userRole', user.data?.role ?? 0);
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

        var group = GroupResponse.fromMap(responseData);
        return group;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Gọi API thất bại');
    }
  }
}
