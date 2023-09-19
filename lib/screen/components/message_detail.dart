// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat/blocs/bloc_message/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageDetail extends StatefulWidget {
  final String selectedConversation;

  const MessageDetail({super.key, required this.selectedConversation});

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  void sendMessage(BuildContext context) {
    context.read<MessageBloc>().add(AddMessage(message: _controller.text));
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // final List<Message> messages = [
    //   Message(
    //     content: 'Tin nhắn 1 của Client',
    //     time: '12:00 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 2 của Server',
    //     time: '12:05 PM',
    //     senderID: 'Server',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 3 của Client',
    //     time: '12:10 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 1 của Client',
    //     time: '12:00 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 2 của Server',
    //     time: '12:05 PM',
    //     senderID: 'Server',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 3 của Client',
    //     time: '12:10 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 1 của Client',
    //     time: '12:00 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 2 của Server',
    //     time: '12:05 PM',
    //     senderID: 'Server',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 3 của Client',
    //     time: '12:10 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 1 của Client',
    //     time: '12:00 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 2 của Server',
    //     time: '12:05 PM',
    //     senderID: 'Server',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 3 của Client',
    //     time: '12:10 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 1 của Client',
    //     time: '12:00 PM',
    //     senderID: 'Client',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 2 của Server',
    //     time: '12:05 PM',
    //     senderID: 'Server',
    //   ),
    //   Message(
    //     content: 'Tin nhắn 3 của Client',
    //     time: '12:10 PM',
    //     senderID: 'Client',
    //   ),
    // ];

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
                    'Đang trò chuyện với: ${widget.selectedConversation}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Phần tin nhắn
                Expanded(
                  child: BlocBuilder<MessageBloc, MessageState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return MessageBubble(
                            content: message.message,
                            senderID:message.senderInfo,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Phần nhập tin nhắn
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
                onSubmitted: (value) => sendMessage(context),
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
                onTap: () => sendMessage(context),
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
