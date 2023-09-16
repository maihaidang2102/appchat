// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String selectedConversation;

  const MessageDetail({super.key, required this.selectedConversation});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
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
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(width: 1, color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Đang trò chuyện với: $selectedConversation',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black12),
                  right: BorderSide(width: 1, color: Colors.black12),
                  left: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _controller,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                onSubmitted: (value) {},
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Nhập tin nhắn'),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                splashColor: Colors.grey.shade200,
                hoverColor: Colors.grey.shade200,
                onTap: () {},
                child: Container(
                  height: 50.0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: const Text(
                    "Gửi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
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

  const MessageBubble(
      {super.key, required this.content, required this.senderID});

  @override
  Widget build(BuildContext context) {
    final Color? bubbleColor =
        senderID == 'Client' ? Colors.grey.shade400 : Colors.grey[200];

    final CrossAxisAlignment alignment = senderID == 'Client'
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            'Thời gian: ${DateTime.now().toString()}',
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
