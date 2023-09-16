import 'package:appchatwindown/screen/server_screen/components/body.dart';
import 'package:flutter/material.dart';

class ServerScreen extends StatefulWidget {
  @override
  _ServerScreenState createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  // Danh sách các người nhắn tin
  List<String> conversations = [
    'Người nhắn tin 1',
    'Người nhắn tin 2',
    'Người nhắn tin 3',
    // Thêm các người nhắn tin khác ở đây
  ];

  String selectedConversation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server'),
      ),
      body: BodyServer(conversations: conversations),
    );
  }
}

