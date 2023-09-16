import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final List<String> conversations;
  final Function(String) onSelectConversation;

  const MessageList({
    super.key,
    required this.conversations,
    required this.onSelectConversation,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  int _seleted = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black12)),
      width: 200,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.conversations.length,
        itemBuilder: (context, index) {
          return Container(
            color: _seleted == index ? Colors.grey.shade300 : null,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversations[index],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '2 tin nhắn mới',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _seleted = index;
                });
                widget.onSelectConversation(widget.conversations[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
