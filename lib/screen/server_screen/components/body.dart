import 'package:flutter/material.dart';
import 'message_detail.dart';
import 'message_list.dart';

class BodyServer extends StatefulWidget {
  final List<String> conversations;

  BodyServer({required this.conversations});

  @override
  _BodyServerState createState() => _BodyServerState();
}

class _BodyServerState extends State<BodyServer> {
  String selectedConversation = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Phần bên trái - Danh sách người nhắn tin
        MessageList(
          conversations: widget.conversations,
          onSelectConversation: (conversation) {
            // Xử lý khi một người nhắn tin được chọn
            setState(() {
              selectedConversation = conversation;
            });
          },
        ),
        // Phần bên phải - Tin nhắn chi tiết
        MessageDetail(selectedConversation: selectedConversation),
      ],
    );
  }
}
