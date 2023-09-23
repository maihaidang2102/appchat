// ignore_for_file: library_private_types_in_public_api

import 'package:chat/screen/server_screen/components/body.dart';
import 'package:flutter/material.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  _ServerScreenState createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
 
  String selectedConversation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Máy chủ',
          textScaleFactor: 1,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: const BodyServer(),
    );
  }
}
