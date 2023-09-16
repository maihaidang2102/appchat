// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../components/message_detail.dart';
import '../../components/message_list.dart';

class BodyServer extends StatefulWidget {
  final List<String> conversations;

  const BodyServer({super.key, required this.conversations});

  @override
  _BodyServerState createState() => _BodyServerState();
}

class _BodyServerState extends State<BodyServer> {
  late String selectedConversation;

  @override
  void initState() {
    selectedConversation = widget.conversations.first;
    super.initState();
  }

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
