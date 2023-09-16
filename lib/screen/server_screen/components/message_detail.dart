import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String selectedConversation;

  MessageDetail({required this.selectedConversation});

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = [
      Message(
        content: 'Tin nhắn 1 của Client',
        time: '12:00 PM',
        senderID: 'Client',
      ),
      Message(
        content: 'Tin nhắn 2 của Server',
        time: '12:05 PM',
        senderID: 'Server',
      ),
      Message(
        content: 'Tin nhắn 3 của Client',
        time: '12:10 PM',
        senderID: 'Client',
      ),
    ];

    return Expanded(
      child: Container(
        color: Colors.grey[200], // Màu nền của phần bên phải
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Phần tiêu đề cuộc trò chuyện
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cuộc trò chuyện: $selectedConversation',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Danh sách các tin nhắn
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageBubble(
                    content: message.content,
                    senderID: message.senderID,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final String time;
  final String senderID;

  Message({
    required this.content,
    required this.time,
    required this.senderID,
  });
}

class MessageBubble extends StatelessWidget {
  final String content;
  final String senderID;

  MessageBubble({required this.content, required this.senderID});

  @override
  Widget build(BuildContext context) {
    final Color? bubbleColor =
    senderID == 'Client' ? Colors.lightBlue : Colors.grey[300];

    final CrossAxisAlignment alignment =
    senderID == 'Client' ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            content,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Thời gian: ${DateTime.now().toString()}',
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
