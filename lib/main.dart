import 'package:chat/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'api_service/authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trò chuyện',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey, primary: Colors.grey),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
