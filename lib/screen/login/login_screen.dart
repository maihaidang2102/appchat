import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat/api_service/authentication.dart';
import 'package:chat/screen/server_screen/server_screen.dart';
import 'package:chat/screen/client_screen/client_screen.dart';

import '../../api_service/socket_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  late SocketManager socketManager;

  @override
  void initState() {
    super.initState();
    checkAndNavigate();
    socketManager = SocketManager(); // Tạo thể hiện của SocketManager khi màn hình được khởi tạo.
    socketManager.addMessageListener((data) {
      print("Received from WebSocket: $data");
    });
    socketManager.sendData("Hello from Flutter!");
  }

  Future<void> checkAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userID');
    prefs.remove('userRole');
    final userID = prefs.getString('userID');
    final userRole = prefs.getInt('userRole');

    if (userID != null) {
      if (userRole == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ServerScreen()),
        );
      } else if (userRole == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClientScreen()),
        );
      } else {
        // Xử lý trường hợp khác tùy theo role
      }
    } else {
      // Nếu userID là null, tiến hành gửi API đăng nhập
      final apiService = ApiServiceAuthentication();
      final userIP = '1.2.3.9.2';

      try {
        final userResponse = await apiService.loginUser(userIP);
        final status = userResponse.status ?? false;
        final role = userResponse.data?.role ?? '0';

        if (status == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userID', userResponse.data?.id ?? '');
          prefs.setInt('userRole', userResponse.data?.role ?? 0);

          if (role == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServerScreen()),
            );
          } else if (role == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientScreen()),
            );
          } else {
            // Xử lý trường hợp khác tùy theo role
          }
        } else {
          // Xử lý trường hợp API trả về status là false (đăng ký thất bại)
          print('Đăng ký thất bại');
        }
      } catch (e) {
        // Xử lý lỗi từ API
        print('Đăng nhập thất bại: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: 'Nhập IP:',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll(Colors.grey.shade200),
                overlayColor: const MaterialStatePropertyAll(Colors.grey),
              ),
              onPressed: () async {
                final apiService = ApiServiceAuthentication();
                final userIP = '1.2.3.9.2';

                try {
                  final prefs = await SharedPreferences.getInstance();
                  final userResponse = await apiService.registerUser(userIP);
                  final role = userResponse.data?.role ?? '0';
                  prefs.setString('userID', userResponse.data?.id ?? '');
                  prefs.setInt('userRole', userResponse.data?.role ?? 0);

                  if (role == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ServerScreen()),
                    );
                  } else if (role == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ClientScreen()),
                    );
                  } else {
                    // Xử lý trường hợp khác tùy theo role
                  }
                } catch (e) {
                  // Xử lý lỗi từ API
                  print('Đăng nhập thất bại: $e');
                }
              },
              child: const Text(
                'Bắt đầu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Đảm bảo đóng kết nối WebSocket khi màn hình bị hủy.
    socketManager.close();
    super.dispose();
  }
}