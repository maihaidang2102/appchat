// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';

import 'package:chat/screen/server_screen/server_screen.dart';
import 'package:flutter/material.dart';

import '../client_screen/client_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          textScaleFactor: 1,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    labelText: 'Nhập IP:',
                    
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
                overlayColor: const MaterialStatePropertyAll(Colors.grey),
              ),
              onPressed: () async {
                // Kiểm tra địa chỉ IP của máy hiện tại
                final addresses = await NetworkInterface.list();
                for (var interface in addresses) {
                  for (var addr in interface.addresses) {
                    if (addr.address == '192.168.1.6') {
                      // Nếu là 192.168.1.6, hiển thị màn hình Client1
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServerScreen()),
                      );
                      return;
                    }
                  }
                }

                // Nếu không phải 192.168.1.6, hiển thị màn hình Client2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientScreen()),
                );
              },
              child: const Text(
                'Bắt đầu',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
