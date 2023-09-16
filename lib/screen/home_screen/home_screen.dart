import 'dart:io';

import 'package:appchatwindown/screen/server_screen/server_screen.dart';
import 'package:flutter/material.dart';

import '../client_screen/client_screen.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ServerScreen(),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Kiểm tra địa chỉ IP của máy hiện tại
            final addresses = await NetworkInterface.list();
            for (var interface in addresses) {
              for (var addr in interface.addresses) {
                if (addr.address == '192.168.1.6') {
                  // Nếu là 192.168.1.6, hiển thị màn hình Client1
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServerScreen()),
                  );
                  return;
                }
              }
            }

            // Nếu không phải 192.168.1.6, hiển thị màn hình Client2
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientScreen()),
            );
          },
          child: Text('Bắt đầu'),
        ),
      ),
    );
  }
}
