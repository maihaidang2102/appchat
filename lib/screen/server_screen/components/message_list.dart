import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<String> conversations;
  final Function(String) onSelectConversation;

  MessageList({
    required this.conversations,
    required this.onSelectConversation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversations[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2 tin nhắn mới',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            onTap: () {
              onSelectConversation(conversations[index]);
            },
          );
        },
      ),
    );
  }
}
